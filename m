From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 06 Mar 2014 15:51:31 +0100
Subject: [PATCH] ARM: mvebu: add Device Tree for the Armada 385 RD board
In-Reply-To: <20140306144600.GM4780@lunn.ch>
References: <1394107868-26094-1-git-send-email-gregory.clement@free-electrons.com>
 <20140306131429.GJ4780@lunn.ch> <5318779C.8030901@free-electrons.com>
 <20140306142117.GL4780@lunn.ch> <531886B4.2070002@free-electrons.com>
 <20140306144600.GM4780@lunn.ch>
Message-ID: <53188B73.4000109@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2014 15:46, Andrew Lunn wrote:
>>>>> I think you can use aliases to get the order correct, independent of
>>>>> how you list them in DT. That should be a lot safer than assuming
>>>>> things are instantiated from top to bottom.
>>>>
>>>> It sounds interesting, how would you do this?
>>>
>>> As there already is in armada-370-xp.dtsi
>>>
>>>         aliases {
>>>                 eth0 = &eth0;
>>>                 eth1 = &eth1;
>>>         };
>>>
>>>
>>> 	eth0: ethernet at 70000 {
>>> 	}
>>>         eth1: ethernet at 74000 {
>>> 	}
>>>
>>> This at least works for i2c devices. The pdev->id is set using the
>>> alias number.
>>
>> Well I think it doesn't work with ethernet devices because we already do
>> this in aramda-38x.dtsi:
>>
>> 	aliases {
>> 		gpio0 = &gpio0;
>> 		gpio1 = &gpio1;
>> 		eth0 = &eth0;
>> 		eth1 = &eth1;
>> 		eth2 = &eth2;
>> 	};
>>
>> 	eth1: ethernet at 30000 {
>> 	}
>> 	eth2: ethernet at 34000 {
>> 	}
>> 	eth0: ethernet at 70000 {
>> 	}
> 
> Ah, Erm, O.K. 
> 
> It seems to be an i2c thing. Take a look at i2c_add_adapter().
> 
>         if (dev->of_node) {
>                 id = of_alias_get_id(dev->of_node, "i2c");
>  
> You could put something similar into the ethernet driver.
> 


Actually even what I did, didn't work as I expected. The order should have been changed in
the dsi file.

I will have a look on the ethernet driver.


Thanks,

Gregory


>     Andrew
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
