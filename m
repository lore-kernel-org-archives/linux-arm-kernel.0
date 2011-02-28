From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 28 Feb 2011 17:26:50 +0900
Subject: [PATCH] ARM: EXYNOS4: Adds Samsung NURI board support
In-Reply-To: <4D6B5949.8020606@samsung.com>
References: <4D676BB8.9040803@samsung.com>
	<002301cbd71b$1969bd00$4c3d3700$%kim@samsung.com>
	<4D6B5949.8020606@samsung.com>
Message-ID: <002801cbd721$42e4bad0$c8ae3070$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minkyu Kang wrote:
> 
> Dear Kukjin Kim,
> 
> 2011-02-28 ?? 4:42, Kukjin Kim ? ?:
> > Minkyu Kang wrote:
> >>
> >> This patch adds Samsung NURI board support.
> >>
> >> Signed-off-by: Minkyu Kang <mk7.kang@samsung.com>
> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >> ---
> >> This patch is base on next-exynos4 branch at kgene tree.
> >>
> >>  arch/arm/configs/exynos4_defconfig |    1 +
> >>  arch/arm/mach-exynos4/Kconfig      |   15 +++
> >>  arch/arm/mach-exynos4/Makefile     |    1 +
> >>  arch/arm/mach-exynos4/mach-nuri.c  |  233
> >> ++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 250 insertions(+), 0 deletions(-)
> >>  create mode 100644 arch/arm/mach-exynos4/mach-nuri.c
> >>
> >
> >> +enum fixed_regulator_id {
> >> +	FIXED_REG_ID_MMC = 0,
> >
> > 	FIXED_REG_ID_MMC,
> >
> > (snip)
> >
> >> +static struct platform_device emmc_fixed_voltage = {
> >> +	.name			= "reg-fixed-voltage",
> >> +	.id			= FIXED_REG_ID_MMC,
> >
> > Is there any reason to use FIXED_REG_ID_MMC instead directly id 0?
> >
> 
> I'm going to add more IDs of fixed regulator that are LCD and Backlight, and
> so on.
> So use enum values for avoid the hard coding.
> 

Ok, applied this after removing "ifdef WATCHDOG".
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
