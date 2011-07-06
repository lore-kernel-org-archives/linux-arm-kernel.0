From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:46:53 -0400
Subject: [PATCH 08/52] ARM: mach-exynos4: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-8-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-exynos4/mach-armlex4210.c     |    2 +-
 arch/arm/mach-exynos4/mach-nuri.c           |    2 +-
 arch/arm/mach-exynos4/mach-smdkc210.c       |    2 +-
 arch/arm/mach-exynos4/mach-smdkv310.c       |    2 +-
 arch/arm/mach-exynos4/mach-universal_c210.c |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos4/mach-armlex4210.c b/arch/arm/mach-exynos4/mach-armlex4210.c
index b482c62..f0ca6c1 100644
--- a/arch/arm/mach-exynos4/mach-armlex4210.c
+++ b/arch/arm/mach-exynos4/mach-armlex4210.c
@@ -207,7 +207,7 @@ static void __init armlex4210_machine_init(void)
 
 MACHINE_START(ARMLEX4210, "ARMLEX4210")
 	/* Maintainer: Alim Akhtar <alim.akhtar@samsung.com> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= armlex4210_map_io,
 	.init_machine	= armlex4210_machine_init,
diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index 642702b..c70ff9d 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -402,7 +402,7 @@ static void __init nuri_machine_init(void)
 
 MACHINE_START(NURI, "NURI")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= nuri_map_io,
 	.init_machine	= nuri_machine_init,
diff --git a/arch/arm/mach-exynos4/mach-smdkc210.c b/arch/arm/mach-exynos4/mach-smdkc210.c
index e645f7a..b9a9909 100644
--- a/arch/arm/mach-exynos4/mach-smdkc210.c
+++ b/arch/arm/mach-exynos4/mach-smdkc210.c
@@ -215,7 +215,7 @@ static void __init smdkc210_machine_init(void)
 
 MACHINE_START(SMDKC210, "SMDKC210")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkc210_map_io,
 	.init_machine	= smdkc210_machine_init,
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
index 1526764..3934274 100644
--- a/arch/arm/mach-exynos4/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -240,7 +240,7 @@ static void __init smdkv310_machine_init(void)
 MACHINE_START(SMDKV310, "SMDKV310")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	/* Maintainer: Changhwan Youn <chaos.youn@samsung.com> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
 	.init_machine	= smdkv310_machine_init,
diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c b/arch/arm/mach-exynos4/mach-universal_c210.c
index 97d329f..df80cd8 100644
--- a/arch/arm/mach-exynos4/mach-universal_c210.c
+++ b/arch/arm/mach-exynos4/mach-universal_c210.c
@@ -642,7 +642,7 @@ static void __init universal_machine_init(void)
 
 MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= exynos4_init_irq,
 	.map_io		= universal_map_io,
 	.init_machine	= universal_machine_init,
-- 
1.7.4
