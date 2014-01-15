From: lho@apm.com (Loc Ho)
Date: Wed, 15 Jan 2014 14:07:18 -0800
Subject: [PATCH v9 2/4] Documentation: Add documentation for APM X-Gene
 SoC SATA host controller DTS binding
In-Reply-To: <4632602.a1zUZOeMuh@wuerfel>
References: <1389769910-15505-1-git-send-email-lho@apm.com>
 <5905127.tqJ3nFt5cj@wuerfel>
 <CAPw-ZTmVYfPLUVmtes3Gn8Z=+gyFtLoZxc-QUdHH7-ePjKAG9A@mail.gmail.com>
 <4632602.a1zUZOeMuh@wuerfel>
Message-ID: <CAPw-ZTmn-aNJcLd1mZPRtog_ncq=GC94ULCJb-400oYqERYK5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> >> >> +- clocks             : Reference to the clock entry.
>> >> >> +- phys                       : PHY reference with parameter 0.
>> >> >
>> >> > The specific value of the phy-specifier shouldn't matter to this
>> >> > binding. What should matter is what it logically corresponds to.
>> >>
>> >> I not quite following this. Are you suggest that I drop the value 0.
>> >> In the binding, one needs to specify the mode of operation - 0 is for
>> >> SATA. Can you explain more?
>> >
>> > The SATA device should not care what the argument for the PHY
>> > device is. You could connect the same device to another PHY
>> > that has a different set of arguments, which is the whole point
>> > of abstracting it.
>> >
>>
>> I understand what you wrote here. We should not have an argument from
>> the host controller. Then my question is how should the PHY node
>> indicates that it needs to be configured itself as an SATA PHY?
>
> The "phys" property should specify whatever the configuration of
> the phy device is supposed to be. It's just not the business of
> the sata driver or the sata binding to know what that configuration
> is.
>

Here is what I have and I am trying to piece this together:

phy1 {
   #phy-cells = <0>;  /* No parameter as suggest by Mark */
};

sata1 {
    :::
    phys = <&phy1>;
};

What I don't get is how does one specify the mode
(SATA/USB/SGMII/etc)? As another parameter in the phy1 node?

-Loc
