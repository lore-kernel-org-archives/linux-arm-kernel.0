From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 21 Nov 2018 12:00:52 +0100
Subject: [PATCH] ARM: dts: at91: sama5d2: use the divided clock for SMC
In-Reply-To: <20181120204049.GG8367@piout.net>
References: <20181120165737.4998-1-romain.izard.pro@gmail.com>
 <20181120171612.GF8367@piout.net>
 <CAGkQfmPHRKqMvm6bNDf8S5qM7uE5T-izij=jm2nob0zrOgOM-w@mail.gmail.com>
 <20181120204049.GG8367@piout.net>
Message-ID: <20181121110052.GK8367@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/2018 21:40:49+0100, Alexandre Belloni wrote:
> On 20/11/2018 19:01:32+0100, Romain Izard wrote:
> > Le mar. 20 nov. 2018 ? 18:16, Alexandre Belloni
> > <alexandre.belloni@bootlin.com> a ?crit :
> > >
> > > Hello Romain,
> > >
> > > On 20/11/2018 17:57:37+0100, Romain Izard wrote:
> > > > The SAMA5D2 is different from SAMA5D3 and SAMA5D4, as there are two
> > > > different clocks for the peripherals in the SoC. The Static Memory
> > > > controller is connected to the divided master clock.
> > > >
> > > > Unfortunately, the device tree does not correctly show this and uses the
> > > > master clock directly. This clock is then used by the code for the NAND
> > > > controller to calculate the timings for the controller, and we end up with
> > > > slow NAND Flash access.
> > > >
> > > > Fix the device tree, and the performance of Flash access is improved.
> > > >
> > > > Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> > > > ---
> > > >  arch/arm/boot/dts/sama5d2.dtsi | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> > > > index 61f68e5c48e9..b405992eb601 100644
> > > > --- a/arch/arm/boot/dts/sama5d2.dtsi
> > > > +++ b/arch/arm/boot/dts/sama5d2.dtsi
> > > > @@ -308,7 +308,7 @@
> > > >                                 0x1 0x0 0x60000000 0x10000000
> > > >                                 0x2 0x0 0x70000000 0x10000000
> > > >                                 0x3 0x0 0x80000000 0x10000000>;
> > > > -                     clocks = <&mck>;
> > > > +                     clocks = <&h32ck>;
> > >
> > > You will have to rebase on top of at91-dt. And if I'm not mistaken, this
> > > line should be:
> > >
> > > +                       clocks = <&pmc PMC_TYPE_CORE PMC_MCK2>;
> > >
> > > >                       status = "disabled";
> > > >
> > > >                       nand_controller: nand-controller {
> > 
> > I guess you're right but this will only reach mainline in 4.21. I get slow
> > flash access with 4.19 as well...
> >
> 
> Ok, this is super annoying, I'll try to get that as fixes on v4.20 and
> I'll rebase at91-dt on top of that...
> 

So, I did that just now.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
