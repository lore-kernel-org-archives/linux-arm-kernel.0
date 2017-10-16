From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 Oct 2017 14:06:33 +0200
Subject: [PATCH 2/6] ARM: sun8i: r40: add USB host port nodes for R40
In-Reply-To: <7ee77556174b84846a59d57525ec1cb9@aosc.io>
References: <20171008042906.46779-1-icenowy@aosc.io>
 <20171008042906.46779-3-icenowy@aosc.io>
 <20171009210340.ak6wo3vqnwj4gom4@flea.home>
 <55B35500-67FC-40AA-9A07-98C843DE55B3@aosc.io>
 <20171016093229.waizww2n4gwn4qpw@flea.lan>
 <7ee77556174b84846a59d57525ec1cb9@aosc.io>
Message-ID: <20171016120633.6jof6wvsre27rxhv@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 05:39:58PM +0800, icenowy at aosc.io wrote:
> ? 2017-10-16 17:32?Maxime Ripard ???
> > On Tue, Oct 10, 2017 at 07:24:28AM +0800, Icenowy Zheng wrote:
> > > >> +			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> > > >> +			clocks = <&ccu CLK_BUS_OHCI1>,
> > > >> +				 <&ccu CLK_BUS_EHCI1>,
> > > >> +				 <&ccu CLK_USB_OHCI1>;
> > > >> +			resets = <&ccu RST_BUS_OHCI1>,
> > > >> +				 <&ccu RST_BUS_EHCI1>;
> > > >
> > > >Why do you need to take the OHCI resources too?
> > > 
> > > AW's strange design -- without OHCI resources taken EHCI
> > > won't work.
> > 
> > How has this been tested?
> 
> As EHCI is probed before OHCI, this behavior is easy to
> appear if the OHCI resources are removed.

And what is "this behaviour" exactly?

What have you tested, what device did you connect, what is the outcome
that isn't something you expected, etc.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171016/c307ddc5/attachment-0001.sig>
