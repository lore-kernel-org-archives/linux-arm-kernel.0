From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Apr 2014 17:23:28 +0200
Subject: [PATCH 2/5] ARM: dts: Device tree for AXM55xx.
In-Reply-To: <20140415152047.GB32285@swsaberg01>
References: <cover.1397552154.git.anders.berg@lsi.com>
 <8344066.GP0Bf5lvlE@wuerfel> <20140415152047.GB32285@swsaberg01>
Message-ID: <11327885.Oem0QkHdqf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 April 2014 17:20:47 Anders Berg wrote:
> > > +                   gpio0: gpio at 2010092000 {
> > > +                           #gpio-cells = <2>;
> > > +                           compatible = "arm,pl061", "arm,primecell";
> > > +                           gpio-controller;
> > > +                           reg = <0x20 0x10092000 0x00 0x1000>;
> > > +                           interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> > > +                                        <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> > > +                                        <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> > > +                                        <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> > > +                                        <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> > > +                                        <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> > > +                                        <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> > > +                                        <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > > +                           clocks = <&clk_per>;
> > > +                           clock-names = "apb_pclk";
> > > +                           status = "disabled";
> > 
> > The pl061 binding does not specify any clocks at all. Do we need to update
> > that?
> 
> Doesn't all AMBA devices need at least one apb_pclk since the bus driver does
> clk_get(...,"apb_pclk") before calling probe()?

Yes, I was mostly wondering whether we had a policy about whether this clock
should also be listed in the binding or not. My feeling is that it's better
to make that explicit.

	Arnd
