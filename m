From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 27 Nov 2012 12:32:24 +0100
Subject: [PATCH] ARM: dts: add initial dts file for ORIGEN4QUAD
In-Reply-To: <50B495B9.4060005@insignal.co.kr>
References: <1353929538-24173-1-git-send-email-kh.choi@insignal.co.kr>
 <1361143.TuLvfqvMr1@amdc1227> <50B495B9.4060005@insignal.co.kr>
Message-ID: <3266033.etMBVlqbyR@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kyuho,

On Tuesday 27 of November 2012 19:28:09 kh.choi wrote:
> Hi Tomasz,
> 
> 2012-11-26 ?? 8:57, Tomasz Figa ? ?:
> > Hi Kyungmin, Kyuho,
> > 
> > On Monday 26 of November 2012 20:52:12 Kyungmin Park wrote:
> >> Hi,
> >> 
> >> On 11/26/12, chlrbgh0 at gmail.com <chlrbgh0@gmail.com> wrote:
> >>> From: Kyuho Choi <kh.choi@insignal.co.kr>
> >>> 
> >>> This patch adds initial dts file for ORIGEN4QUAD board.
> >>> ORIGEN4QUAD board based on Samsung EXYNOS4412 SoC.
> >>> More properties will be added later.
> >>> 
> >>> Signed-off-by: Kyuho Choi <kh.choi@insignal.co.kr>
> >>> ---
> >>> 
> >>>   arch/arm/boot/dts/exynos4412-origen4quad.dts |   45
> >>> 
> >>> ++++++++++++++++++++++++++
> >>> 
> >>>   1 files changed, 45 insertions(+), 0 deletions(-)
> >>>   create mode 100644 arch/arm/boot/dts/exynos4412-origen4quad.dts
> >>> 
> >>> diff --git a/arch/arm/boot/dts/exynos4412-origen4quad.dts
> >>> b/arch/arm/boot/dts/exynos4412-origen4quad.dts
> >>> new file mode 100644
> >>> index 0000000..390a2ab
> >>> --- /dev/null
> >>> +++ b/arch/arm/boot/dts/exynos4412-origen4quad.dts
> >>> @@ -0,0 +1,45 @@
> >>> +/*
> >>> + * Samsung's Exynos4412 based Origen4Quad board device tree source
> >>> + *
> >>> + * Copyright (c) 2012-2013 Isnignal Co., Ltd.
> >>> + *		http://www.insignal.co.kr
> >>> + *
> >>> + * Device tree source file for Insignal's Origen4Quad board which
> >>> is
> >>> based on
> >>> + * Samsung's Exynos4412 SoC.
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or
> >>> modify + * it under the terms of the GNU General Public License
> >>> version 2 as + * published by the Free Software Foundation.
> >>> +*/
> >>> +
> >>> +/dts-v1/;
> >>> +/include/ "exynos4412.dtsi"
> >>> +
> >>> +/ {
> >>> +	model = "Insignal Origen4Quad board based on Exynos4412";
> >>> +	compatible = "insignal,origen4quad", "samsung,exynos4412";
> >>> +
> >>> +	memory {
> >>> +		reg = <0x40000000 0x40000000>;
> >>> +	};
> >> 
> >> does it test to boot with this dts file?
> >> does it support 1GiB memory section?
> > 
> > It will most likely fail to boot with u-boot versions that do not
> > support replacing memory configuration in device tree and without
> > CONFIG_ARM_ATAG_DTB_COMPAT enabled.
> > 
> > In other words, the memory setup from dts is used only if both of the
> > 
> > following are true:
> >   - CONFIG_ARM_ATAG_DTB_COMPAT is disabled
> >   - u-boot does not modify memory setup in device tree passed to the
> >   kernel
> I'd working based on `exynos4_defconfig` for ORIGEN4QUAD board.
> `exynos4_defconfig`s default disabled CONFIG_ARM_ATAG_DTB_COMPAT.
> And ORIGEN4QUAD working on u-boot v2012.10.

This means that u-boot version you use modifies memory setup in device 
tree before passing it to the kernel.

You can try to boot with empty memory node or no memory node at all and 
check what memory configuration the kernel gets in /proc/device-tree, for 
example using

xxd -c8 -g4 /proc/device-tree/memory/reg

Still, the maximum section size for mach-exynos is set in kernel to 256MiB 
and so the memory in reg property such be defined in chunks less or equal 
256 MiB.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
