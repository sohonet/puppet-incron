require 'puppet/provider/parsedfile'

incrondeny = case Facter.value(:osfamily)
  when 'RedHat'
    "/etc/incron.deny"
  else
    "/etc/incron.deny"
  end

Puppet::Type.type(:incron_denyuser).provide(:parsed, :parent => Puppet::Provider::ParsedFile, :default_target => incrondeny, :filetype => :flat) do

  desc "The incron_allowuser provider that uses the ParsedFile class"

  def flush
    unless File.exists?(@resource[:target])
      File.open(@resource[:target], 'w') do |file| 
        file.write ""
      end 
    end 

    super
  end
  
  text_line :comment, :match => /^#/;
  text_line :blank, :match => /^\s*$/;
  
  record_line :parsed, :fields => %w{name}
end
