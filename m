From: anders.berg@lsi.com (Anders Berg)
Date: Thu, 24 Apr 2014 19:47:41 +0200
Subject: [PATCH v2 3/6] ARM: dts: Device tree for AXM55xx.
In-Reply-To: <CACRpkdbU6UashxCuPMDjEB_nbB=mXicGpjJy=HGC6r3qfxCtVQ@mail.gmail.com>
References: <cover.1398335771.git.anders.berg@lsi.com>
 <2386bd1367aa44741979461358a72dec89608597.1398335771.git.anders.berg@lsi.com>
 <CACRpkdbU6UashxCuPMDjEB_nbB=mXicGpjJy=HGC6r3qfxCtVQ@mail.gmail.com>
Message-ID: <20140424174741.GA23444@swsaberg01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 03:24:14PM +0200, Linus Walleij wrote:
> On Thu, Apr 24, 2014 at 12:44 PM, Anders Berg <anders.berg@lsi.com> wrote:
> 
> > Add device tree for the Amarillo validation board with an AXM5516 SoC.
> >
> > Signed-off-by: Anders Berg <anders.berg@lsi.com>
> (...)
> 
> > +                       timer0: timer at 2010091000 {
> > +                               compatible = "arm,sp804", "arm,primecell";
> > +                               reg = <0x20 0x10091000 0 0x1000>;
> > +                               interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> > +                               clocks = <&clk_per>;
> > +                               clock-names = "apb_pclk";
> > +                               status = "okay";
> > +                       };
> > +
> > +                       gpio0: gpio at 2010092000 {
> > +                               #gpio-cells = <2>;
> > +                               compatible = "arm,pl061", "arm,primecell";
> > +                               gpio-controller;
> > +                               reg = <0x20 0x10092000 0x00 0x1000>;
> > +                               interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > +                               clocks = <&clk_per>;
> > +                               clock-names = "apb_pclk";
> > +                               status = "disabled";
> > +                       };
> 
> One interrupt per CPU core?
> 
> The drivers for these blocks will really just grab the first IRQ and
> then I guess they
> will only be able to execute on CPU0.
> 
> It's definately correct to list all the IRQs here, but how do you envision
> the drivers making use of them in the long run?

It's one interrupt line per input pin (so with the current driver only the first pin
is usable as interrupt source).

/Anders

> 
> Yours,
> Linus Walleij
> 
