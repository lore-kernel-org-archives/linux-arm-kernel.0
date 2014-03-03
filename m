From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 03 Mar 2014 10:26:23 +0100
Subject: [PATCH 4/7] ARM: dts: exynos5440: fix PCIe interrupt mapping
In-Reply-To: <000501cf36b5$b0a27110$11e75330$%han@samsung.com>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
 <1393608523-17509-5-git-send-email-l.stach@pengutronix.de>
 <000401cf36b3$e4aa0fb0$adfe2f10$%han@samsung.com>
 <000501cf36b5$b0a27110$11e75330$%han@samsung.com>
Message-ID: <1393838783.4714.0.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 03.03.2014, 16:53 +0900 schrieb Jingoo Han:
> On Monday, March 03, 2014 4:41 PM, Jingoo Han wrote:
> > On Saturday, March 01, 2014 2:29 AM, Lucas Stach wrote:
> > >
> > > So it actually works.
> > >
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > >  arch/arm/boot/dts/exynos5440.dtsi | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
> > > index 02a0a1226cef..65d425d9ec27 100644
> > > --- a/arch/arm/boot/dts/exynos5440.dtsi
> > > +++ b/arch/arm/boot/dts/exynos5440.dtsi
> > > @@ -274,7 +274,7 @@
> > >  			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /* non-prefetchable memory */
> > >  		#interrupt-cells = <1>;
> > >  		interrupt-map-mask = <0 0 0 0>;
> > > -		interrupt-map = <0x0 0 &gic 53>;
> > > +		interrupt-map = <0 0 0 0 &gic GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> > 
> > It makes build errors as below:
> > 
> > DTC     arch/arm/boot/dts/exynos5440-ssdk5440.dtb
> > Error: arch/arm/boot/dts/exynos5440.dtsi:289.33-34 syntax error
> > FATAL ERROR: Unable to parse input tree
> > make[1]: *** [arch/arm/boot/dts/exynos5440-ssdk5440.dtb] Error 1
> > make: *** [exynos5440-ssdk5440.dtb] Error 2
> > 
> > Would you fix it?
> 
> I fixed build errors after including 'arm-gic.h' as below:
> 
> --- a/arch/arm/boot/dts/exynos5440.dtsi
> +++ b/arch/arm/boot/dts/exynos5440.dtsi
> @@ -9,6 +9,8 @@
>   * published by the Free Software Foundation.
>  */
> 
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
>  #include "skeleton.dtsi"
> 
> Would you confirm this?

That's the right fix, I'll include this (together with the other
feedback I received) in v2 of the series.

Regards,
Lucas

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
