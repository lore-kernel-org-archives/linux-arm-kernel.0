From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 09 Aug 2013 13:56:05 +0200
Subject: [PATCH] ARM: EXYNOS: always enable PM domains support for EXYNOS4x12
Message-ID: <2897494.fSQeGUd9YR@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently PM domains support will be enabled for EXYNOS4x12 SoCs
only if EXYNOS4210 SoC or EXYNOS5250 SoC support is also enabled.

Fix it by explicitly selecting PM domains support (if PM support
is enabled) by SOC_EXYNOS4212 and SOC_EXYNOS4412 config options.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

Index: b/arch/arm/mach-exynos/Kconfig
===================================================================
--- a/arch/arm/mach-exynos/Kconfig	2013-08-08 14:36:02.000000000 +0200
+++ b/arch/arm/mach-exynos/Kconfig	2013-08-08 14:38:48.967486318 +0200
@@ -52,6 +52,7 @@ config SOC_EXYNOS4212
 	depends on ARCH_EXYNOS4
 	select ARCH_HAS_BANDGAP
 	select PINCTRL_EXYNOS
+	select PM_GENERIC_DOMAINS if PM
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
 	select SAMSUNG_DMADEV
@@ -64,6 +65,7 @@ config SOC_EXYNOS4412
 	depends on ARCH_EXYNOS4
 	select ARCH_HAS_BANDGAP
 	select PINCTRL_EXYNOS
+	select PM_GENERIC_DOMAINS if PM
 	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS4412 SoC support
