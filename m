From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 18 Dec 2012 07:47:23 +0100
Subject: [PATCH 1/4] ODROID-X: dts: Add board dts file for ODROID-X
In-Reply-To: <CAOesGMj05zX=h+79t=-GPO3YCL1R-ognrPEn7EEyw0CTdCvkHg@mail.gmail.com>
References: <1355774107-364-1-git-send-email-tobetter@gmail.com>
 <1355774107-364-2-git-send-email-tobetter@gmail.com>
 <CAOesGMgZWNiCmTFGvr--zKf+vS51hX5jPnD+NZq8OvGFLS9rJA@mail.gmail.com>
 <20121218060009.GK23971@game.jcrosoft.org>
 <CAOesGMj05zX=h+79t=-GPO3YCL1R-ognrPEn7EEyw0CTdCvkHg@mail.gmail.com>
Message-ID: <20121218064723.GN23971@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:14 Mon 17 Dec     , Olof Johansson wrote:
> On Mon, Dec 17, 2012 at 10:00 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > On 17:56 Mon 17 Dec     , Olof Johansson wrote:
> >> On Mon, Dec 17, 2012 at 11:55 AM, Dongjin Kim <tobetter@gmail.com> wrote:
> >> > Add initial dtb file for Hardkernel's ODROID-X board based on EXYNOS4412 SoC.
> >> >
> >> > Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> >> > ---
> >> >  arch/arm/boot/dts/Makefile               |    1 +
> >> >  arch/arm/boot/dts/exynos4412-odroidx.dts |   52 ++++++++++++++++++++++++++++++
> >> >  2 files changed, 53 insertions(+)
> >> >  create mode 100644 arch/arm/boot/dts/exynos4412-odroidx.dts
> >> >
> >> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> >> > index ca6fb8e..3355af9 100644
> >> > --- a/arch/arm/boot/dts/Makefile
> >> > +++ b/arch/arm/boot/dts/Makefile
> >> > @@ -45,6 +45,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
> >> >         exynos5250-smdk5250.dtb \
> >> >         exynos5440-ssdk5440.dtb \
> >> >         exynos4412-smdk4412.dtb \
> >> > +       exynos4412-odroidx.dtb \
> >>
> >> Please add them alphabetically, so before smdk.
> > we need to drop the \ \ stuff it will end with merge conflict
> > as if you add 2 dtb at the end you will end with 2 patch that touch the same
> > previous line
> 
> ..which is why the dts files should be added alphabetically instead of
> just appended to the list.
we need to drop this \

and use this syntax and keep ordered
dtb-$() +=

> 
> >> > diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
> >> > new file mode 100644
> >> > index 0000000..786ddd7
> >> > --- /dev/null
> >> > +++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
> >> > @@ -0,0 +1,52 @@
> >> > +/*
> >> > + * Hardkernel's Exynos4412 based ODROID-X board device tree source
> >> > + *
> >> > + * Copyright (c) 2012-2013 Dongjin Kim <tobetter@gmail.com>
> >>
> >> Are you from the future?
> >>
> >> > + *
> >> > + * Device tree source file for Hardkernel's ODROID-X board which is based on
> >> > + * Samsung's Exynos4412 SoC.
> >> > + *
> >> > + * This program is free software; you can redistribute it and/or modify
> >> > + * it under the terms of the GNU General Public License version 2 as
> >> > + * published by the Free Software Foundation.
> >> > +*/
> >> > +
> >> > +/dts-v1/;
> >> > +/include/ "exynos4412.dtsi"
> >> > +
> >> > +/ {
> >> > +       model = "Hardkernel ODROID-X board based on Exynos4412";
> >> > +       compatible = "samsung,exynos4412";
> >>
> >> It should have a more specific compatible value first, i.e.
> >> "hardkernel,odroid-x" or similar.
> >>
> >>
> >> > +       memory {
> >> > +               reg = <0x40000000 0x40000000>;
> >> > +       };
> >> > +
> >> > +       chosen {
> >> > +               bootargs ="root=/dev/mmcblk0p3 rw console=ttySAC1,115200 init=/sbin/init delay=2";
> >>
> >> Bootargs should be passed in from u-boot, don't specify them in the
> >> static device tree.
> >
> > why not we can choose to have a default cmdline and even usit as a complement
> > of the bootloader one
> >
> > it's up to the dts maintainer to choose
> 
> The chance of having a valid generic command line that will work for
> everyone with that hardware is fairly small, especially on more
> generic systems that might have a regular distro installed on them.

this does not hurt anyone 99% of the people will overwrite you can just see as
a cmdline example

Best Regards,
J.
