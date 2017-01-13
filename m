From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 13 Jan 2017 14:37:51 -0800
Subject: [PATCH net-next v2 08/10] net: dsa: Add support for platform data
In-Reply-To: <20170113140459.GH10203@lunn.ch>
References: <20170112034121.27697-1-f.fainelli@gmail.com>
 <20170112034121.27697-9-f.fainelli@gmail.com>
 <20170113140459.GH10203@lunn.ch>
Message-ID: <173cffe2-f407-ac43-c5ee-85a70576dd36@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2017 06:04 AM, Andrew Lunn wrote:
>> index cd91070b5467..d326fc4afad7 100644
>> --- a/net/dsa/dsa2.c
>> +++ b/net/dsa/dsa2.c
>> @@ -81,17 +81,23 @@ static void dsa_dst_del_ds(struct dsa_switch_tree *dst,
>>  
>>  static bool dsa_port_is_valid(struct dsa_port *port)
>>  {
>> -	return !!port->dn;
>> +	return !!(port->dn || port->name);
>>  }
>   
> Does this clash with Viviens recent change to make names optional and
> have the kernel assign it?

So there were two ways to look at this, one was that could check here
that ds->pd is assigned and port->name is assigned, which means that
platform data has to provide valid port name. We can also eliminate this
check entirely because we now support NULL names just fines.

> 
> I suppose you could use an name of "eth%d"? Is it worth adding a
> comment to the platform data structure?

Humm, that could be done, maybe for simplicity we can just let
net/dsa/dsa2.c assign names either based on what platform data provided,
or by falling back to eth%d.

Thanks!
-- 
Florian
