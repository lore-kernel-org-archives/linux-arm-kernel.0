From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 23 Aug 2017 23:05:33 +0200
Subject: [EXT] Re: [PATCH net-next 10/18] net: mvpp2: use the GoP
 interrupt for link status changes
In-Reply-To: <20170823160444.GC23960@kwain>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-11-antoine.tenart@free-electrons.com>
 <20170726162648.GK12049@lunn.ch> <20170823082510.GD5202@kwain>
 <5ebd192c54984b25adda0a294035b1b9@IL-EXCH01.marvell.com>
 <20170823160444.GC23960@kwain>
Message-ID: <CAPv3WKcSFcd4kBS_vpTsbf789xsLatuT2TBfZZbiu16sRauk7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

2017-08-23 18:04 GMT+02:00 Antoine Tenart <antoine.tenart@free-electrons.com>:
> On Wed, Aug 23, 2017 at 03:24:55PM +0000, Stefan Chulski wrote:
>> > When the cable is connected (there is signal) and the serdes is in sync and AN
>> > succeeded.
>> >
>> > > With SFF/SFP ports, you generally need a gpio line the fibre module
>> > > can use to indicate if it has link. Fixed-phy has such support, and
>> > > your link_change function will get called when the link changes.
>> >
>> > So that would work when using SFP modules but I wonder if the GoP irq isn't
>> > needed when using passive cable, in which case this patch would still be needed
>> > (and of course we should support the new Russell phylib capabilities).
>>
>> Even if new phylib driver supports passive direct cables connection,
>> GoP IRQ required for SOHO/Peridot external switch support.
>> SOHO/Peridot external switch could be connected directly to Serdes line.
>
> So I guess the GoP link irq patches are needed. Should I resend them
> then?
>
> We'll have to discuss how to handle fixed-phy vs GoP IRQ, but I guess we
> can do this when adding the fixed-phy support later.
>

Please check mvneta.c - you can find there coexistence of normal
libphy support, fixed phy and link irq for the inband management mode.
IMO it's exactly, what you need here.

Best regards,
Marcin
