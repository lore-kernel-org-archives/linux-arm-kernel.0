From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Sep 2011 10:50:02 +0900
Subject: [GIT PULL] Samsung boards for v3.2
In-Reply-To: <201109202230.09426.arnd@arndb.de>
References: <001a01cc76b8$208e52c0$61aaf840$%kim@samsung.com>
	<201109202230.09426.arnd@arndb.de>
Message-ID: <004101cc7800$c7cb8a00$57629e00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Monday 19 September 2011, Kukjin Kim wrote:
> > Please pull from:
> >   git://github.com/kgene/linux-samsung.git next-samsung-board
> >
> > As you see, the next-samsung-board includes new board, SMDK4212. Of
course
> > to support new SoC, EXYNOS4212 is required for it but current
> > arch/arm/mach-exynos4 (ARCH_EXYNOS4) can support it so I merged it into
> > next-samsung-board not next-samsung-soc and to support handling of cupid
> and
> > rev. in Samsung stuff for it. As I remember, you said -soc branch of
arm-soc
> > is for adding new architecture like arch/arm/mach-xxxx.
> >
> > As a note, this includes samsung-fixes-2 which has been already pulled
in
> > your tree too.
> 
> Looks good. I had to apply the same atag_offset change to the new board
> file that was done in all other branches as well.
> 
Yes, as a note, so I have applied following for it in my -next.
It's ok to me either your handling or following.

commit 61338e607202a7cf9d5f63e69eb538782643ff90
Author: Tushar Behera <tushar.behera@linaro.org>
Date:   Mon Sep 19 20:09:01 2011 +0900

    ARM: EXYNOS4: convert boot_params to atag_offset
    
    Based on "ARM: introduce atag_offset to replace boot_params"
    by Nicolas Pitre (2bb9839e312ed55a6d5824ffa6077ce3d7d63b1e).
    
    Since boot_params variable is deleted from machine_desc, the variable
    is modified in the newer board files.
    
    CC: Nicolas Pitre <nicolas.pitre@linaro.org>
    Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
    Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

diff --git a/arch/arm/mach-exynos4/mach-origen.c
b/arch/arm/mach-exynos4/mach-origen.c
index c8121fc..421294b 100644
--- a/arch/arm/mach-exynos4/mach-origen.c
+++ b/arch/arm/mach-exynos4/mach-origen.c
@@ -209,7 +209,7 @@ static void __init origen_machine_init(void)
 
 MACHINE_START(ORIGEN, "ORIGEN")
 	/* Maintainer: JeongHyeon Kim <jhkim@insignal.co.kr> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= origen_map_io,
 	.init_machine	= origen_machine_init,
diff --git a/arch/arm/mach-exynos4/mach-smdk4212.c
b/arch/arm/mach-exynos4/mach-smdk4212.c
index 3479a93..8c41ae1 100644
--- a/arch/arm/mach-exynos4/mach-smdk4212.c
+++ b/arch/arm/mach-exynos4/mach-smdk4212.c
@@ -284,7 +284,7 @@ static void __init smdk4212_machine_init(void)
 
 MACHINE_START(SMDK4212, "SMDK4212")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdk4212_map_io,
 	.init_machine	= smdk4212_machine_init,
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c
b/arch/arm/mach-exynos4/mach-smdkv310.c
index 57cf632..7ce4d8b 100644
--- a/arch/arm/mach-exynos4/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -344,7 +344,7 @@ MACHINE_END
 
 MACHINE_START(SMDKC210, "SMDKC210")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
 	.init_machine	= smdkv310_machine_init,

> Pulled into next/board. Thanks!
> 
Thanks :)

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
