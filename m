From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 24 Dec 2013 15:14:31 +0100
Subject: [PATCH RFC 08/11] ARM: EXYNOS: Kconfig: Fix abuse of CONFIG_PM
In-Reply-To: <1387894474-14428-1-git-send-email-t.figa@samsung.com>
References: <1387894474-14428-1-git-send-email-t.figa@samsung.com>
Message-ID: <1387894474-14428-8-git-send-email-t.figa@samsung.com>
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
---
 arch/arm/mach-exynos/Kconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index f9d67a0..27ea463 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -46,11 +46,11 @@ config CPU_EXYNOS4210
 	default y
 	depends on ARCH_EXYNOS4
 	select ARCH_HAS_BANDGAP
-	select ARM_CPU_SUSPEND if PM
+	select ARM_CPU_SUSPEND if PM_SLEEP
 	select PINCTRL_EXYNOS
-	select PM_GENERIC_DOMAINS if PM
-	select S5P_PM if PM
-	select S5P_SLEEP if PM
+	select PM_GENERIC_DOMAINS if PM_RUNTIME
+	select S5P_PM if PM_SLEEP
+	select S5P_SLEEP if PM_SLEEP
 	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS4210 CPU support
@@ -61,9 +61,9 @@ config SOC_EXYNOS4212
 	depends on ARCH_EXYNOS4
 	select ARCH_HAS_BANDGAP
 	select PINCTRL_EXYNOS
-	select PM_GENERIC_DOMAINS if PM
-	select S5P_PM if PM
-	select S5P_SLEEP if PM
+	select PM_GENERIC_DOMAINS if PM_RUNTIME
+	select S5P_PM if PM_SLEEP
+	select S5P_SLEEP if PM_SLEEP
 	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS4212 SoC support
@@ -74,7 +74,7 @@ config SOC_EXYNOS4412
 	depends on ARCH_EXYNOS4
 	select ARCH_HAS_BANDGAP
 	select PINCTRL_EXYNOS
-	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS if PM_RUNTIME
 	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS4412 SoC support
@@ -85,9 +85,9 @@ config SOC_EXYNOS5250
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
@@ -97,9 +97,9 @@ config SOC_EXYNOS5420
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
1.8.4.3
