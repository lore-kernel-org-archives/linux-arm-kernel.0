From: icenowy@aosc.io (icenowy at aosc.io)
Date: Wed, 18 Oct 2017 20:21:36 +0800
Subject: [PATCH 2/6] ARM: sun8i: r40: add USB host port nodes for R40
In-Reply-To: <20171016120633.6jof6wvsre27rxhv@flea.lan>
References: <20171008042906.46779-1-icenowy@aosc.io>
 <20171008042906.46779-3-icenowy@aosc.io>
 <20171009210340.ak6wo3vqnwj4gom4@flea.home>
 <55B35500-67FC-40AA-9A07-98C843DE55B3@aosc.io>
 <20171016093229.waizww2n4gwn4qpw@flea.lan>
 <7ee77556174b84846a59d57525ec1cb9@aosc.io>
 <20171016120633.6jof6wvsre27rxhv@flea.lan>
Message-ID: <9c98d27b0cf6afb76edf651e67ec2226@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-10-16 20:06?Maxime Ripard ???
> On Mon, Oct 16, 2017 at 05:39:58PM +0800, icenowy at aosc.io wrote:
>> ? 2017-10-16 17:32?Maxime Ripard ???
>> > On Tue, Oct 10, 2017 at 07:24:28AM +0800, Icenowy Zheng wrote:
>> > > >> +			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
>> > > >> +			clocks = <&ccu CLK_BUS_OHCI1>,
>> > > >> +				 <&ccu CLK_BUS_EHCI1>,
>> > > >> +				 <&ccu CLK_USB_OHCI1>;
>> > > >> +			resets = <&ccu RST_BUS_OHCI1>,
>> > > >> +				 <&ccu RST_BUS_EHCI1>;
>> > > >
>> > > >Why do you need to take the OHCI resources too?
>> > >
>> > > AW's strange design -- without OHCI resources taken EHCI
>> > > won't work.
>> >
>> > How has this been tested?
>> 
>> As EHCI is probed before OHCI, this behavior is easy to
>> appear if the OHCI resources are removed.
> 
> And what is "this behaviour" exactly?
> 
> What have you tested, what device did you connect, what is the outcome
> that isn't something you expected, etc.

Oh sorry this weird behavior doesn't exist on R40, although it do exist
on H3/H5/A64.

I will fix this in the next version.

> 
> Maxime
