From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 04 Sep 2014 01:31:21 +0900
Subject: [PATCH v2 5/7] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <3382034.5ADO0F7naY@wuerfel>
References: <1409672143-8574-1-git-send-email-ch.naveen@samsung.com>
 <1409672143-8574-6-git-send-email-ch.naveen@samsung.com>
 <036a01cfc792$422271e0$c66755a0$@samsung.com> <3382034.5ADO0F7naY@wuerfel>
Message-ID: <043401cfc794$7f228650$7d6792f0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
Hi, Arnd

> On Thursday 04 September 2014 01:15:20 Kukjin Kim wrote:
> > Naveen Krishna Chatradhi wrote:
> >
> > > diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-
> > > espresso.dts
> > > new file mode 100644
> > > index 0000000..f6a8879
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> > > @@ -0,0 +1,31 @@
> > > +/*
> > > + * SAMSUNG Exynos7 Espresso board device tree source
> > > + *
> > > + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> > > + *		http://www.samsung.com
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > +*/
> > > +
> > > +/dts-v1/;
> > > +#include "exynos7.dtsi"
> > > +
> > > +/ {
> > > +	model = "Samsung Exynos7 Espresso board based on EXYNOS7";
> > > +	compatible = "samsung,exynos7-espresso", "samsung,exynos7";
> > > +
> > > +	chosen {
> > > +		linux,stdout-path = &serial_2;
> >
> > Well...
> >
> > > +	};
> > > +
> > > +	memory at 40000000 {
> > > +		device_type = "memory";
> > > +		reg = <0x0 0x40000000 0x0 0xC0000000>;
> >
> > The base address of system memory is depending on each board, actually some of
> > them are 0x20000000.
> 
> This is the board specific file, so it seems ok.
> 
I mean there are many espresso boards are having different exynos7 SoC. I mean
exynos7-espresso cannot represent all of espresso boards.

- Kukjin
