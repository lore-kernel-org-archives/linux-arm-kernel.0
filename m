From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Feb 2014 20:12:54 +0100
Subject: [PATCH v2 09/12] ARM: EXYNOS: Kconfig: Fix abuse of CONFIG_PM
In-Reply-To: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
References: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
Message-ID: <1391713977-22300-10-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_PM means that at least one of CONFIG_PM_SLEEP and
CONFIG_PM_RUNTIME is enabled, while multiple entries in
mach-exynos/Kconfig abused it to enable sleep- and runtime-specific
functionality.

This patch fixes this abuse by replacing dependencies on CONFIG_PM with
appropriate dependencies on either CONFIG_PM_SLEEP or CONFIG_PM_RUNTIME,
whichever is appropriate.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 4c414af..0964d97 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -24,7 +24,7 @@ config ARCH_EXYNOS4
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
-	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS if PM_RUNTIME
 	select S5P_DEV_MFC
 	help
 	  Samsung EXYNOS4 SoCs based systems
@@ -47,10 +47,10 @@ config CPU_EXYNOS4210
 	default y
 	depends on ARCH_EXYNOS4
 	select ARCH_HAS_BANDGAP
-	select ARM_CPU_SUSPEND if PM
+	select ARM_CPU_SUSPEND if PM_SLEEP
 	select PINCTRL_EXYNOS
-	select S5P_PM if PM
-	select S5P_SLEEP if PM
+	select S5P_PM if PM_SLEEP
+	select S5P_SLEEP if PM_SLEEP
 	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS4210 CPU support
@@ -61,8 +61,8 @@ config SOC_EXYNOS4212
 	depends on ARCH_EXYNOS4
 	select ARCH_HAS_BANDGAP
 	select PINCTRL_EXYNOS
-	select S5P_PM if PM
-	select S5P_SLEEP if PM
+	select S5P_PM if PM_SLEEP
+	select S5P_SLEEP if PM_SLEEP
 	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS4212 SoC support
@@ -83,9 +83,9 @@ config SOC_EXYNOS5250
 	depends on ARCH_EXYNOS5
 	select ARCH_HAS_BANDGAP
 	select PINCTRL_EXYNOS
-	select PM_GENERIC_DOMAINS if PM
-	select S5P_PM if PM
-	select S5P_SLEEP if PM
+	select PM_GENERIC_DOMAINS if PM_RUNTIME
+	select S5P_PM if PM_SLEEP
+	select S5P_SLEEP if PM_SLEEP
 	select S5P_DEV_MFC
 	select SAMSUNG_DMADEV
 	help
@@ -95,9 +95,9 @@ config SOC_EXYNOS5420
 	bool "SAMSUNG EXYNOS5420"
 	default y
 	depends on ARCH_EXYNOS5
-	select PM_GENERIC_DOMAINS if PM
-	select S5P_PM if PM
-	select S5P_SLEEP if PM
+	select PM_GENERIC_DOMAINS if PM_RUNTIME
+	select S5P_PM if PM_SLEEP
+	select S5P_SLEEP if PM_SLEEP
 	help
 	  Enable EXYNOS5420 SoC support
 
-- 
1.8.5.2
