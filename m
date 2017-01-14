From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 14 Jan 2017 11:12:44 -0800
Subject: [PATCH net-next v2 08/10] net: dsa: Add support for platform data
In-Reply-To: <173cffe2-f407-ac43-c5ee-85a70576dd36@gmail.com>
References: <20170112034121.27697-1-f.fainelli@gmail.com>
 <20170112034121.27697-9-f.fainelli@gmail.com>
 <20170113140459.GH10203@lunn.ch>
 <173cffe2-f407-ac43-c5ee-85a70576dd36@gmail.com>
Message-ID: <eaee94dd-d7f5-1288-3e26-4b680422ed25@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2017 02:37 PM, Florian Fainelli wrote:
> On 01/13/2017 06:04 AM, Andrew Lunn wrote:
>>> index cd91070b5467..d326fc4afad7 100644
>>> --- a/net/dsa/dsa2.c
>>> +++ b/net/dsa/dsa2.c
>>> @@ -81,17 +81,23 @@ static void dsa_dst_del_ds(struct dsa_switch_tree *dst,
>>>  
>>>  static bool dsa_port_is_valid(struct dsa_port *port)
>>>  {
>>> -	return !!port->dn;
>>> +	return !!(port->dn || port->name);
>>>  }
>>   
>> Does this clash with Viviens recent change to make names optional and
>> have the kernel assign it?
> 
> So there were two ways to look at this, one was that could check here
> that ds->pd is assigned and port->name is assigned, which means that
> platform data has to provide valid port name. We can also eliminate this
> check entirely because we now support NULL names just fines.

Considering that the comment above struct dsa_chip_data::port_names in
net/dsa/dsa.h is pretty clear about the port_names usage, I am tempted
to keep the code as-is since without a name, for platform data, we would
not have a way to tell if a port is disabled or not.

Does that work for you?
-- 
Florian
