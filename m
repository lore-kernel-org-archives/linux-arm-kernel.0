From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 18 Jan 2013 16:58:26 +0800
Subject: [PATCH v2] ARM: remove redundant 'select GENERIC_GPIO'
Message-ID: <1358499506-9790-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In drivers/gpio/Kcong, ARCH_REQUIRE_GPIOLIB selects GPIOLIB which in
turn selects GENERIC_GPIO.  So GENERIC_GPIO will be selected
automatically for those platforms that select ARCH_REQUIRE_GPIOLIB.

Remove the redundant 'select GENERIC_GPIO' for platforms that already
select ARCH_REQUIRE_GPIOLIB at either mach or plat level.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes since v1:
 - Update commit log to better explain why the select is unncessary

 arch/arm/Kconfig                |    9 ---------
 arch/arm/mach-bcm/Kconfig       |    1 -
 arch/arm/mach-picoxcell/Kconfig |    1 -
 arch/arm/mach-vt8500/Kconfig    |    1 -
 4 files changed, 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 67874b8..c217521 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -347,7 +347,6 @@ config ARCH_BCM2835
 	select COMMON_CLK
 	select CPU_V6
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_GPIO
 	select MULTI_IRQ_HANDLER
 	select PINCTRL
 	select PINCTRL_BCM2835
@@ -644,7 +643,6 @@ config ARCH_TEGRA
 	select CLKSRC_MMIO
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_GPIO
 	select HAVE_CLK
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
@@ -744,7 +742,6 @@ config ARCH_S3C24XX
 	select ARCH_HAS_CPUFREQ
 	select ARCH_USES_GETTIMEOFFSET
 	select CLKDEV_LOOKUP
-	select GENERIC_GPIO
 	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
@@ -787,7 +784,6 @@ config ARCH_S5P64X0
 	select CLKSRC_MMIO
 	select CPU_V6
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_GPIO
 	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
@@ -802,7 +798,6 @@ config ARCH_S5PC100
 	select ARCH_USES_GETTIMEOFFSET
 	select CLKDEV_LOOKUP
 	select CPU_V7
-	select GENERIC_GPIO
 	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
@@ -820,7 +815,6 @@ config ARCH_S5PV210
 	select CLKSRC_MMIO
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_GPIO
 	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
@@ -838,7 +832,6 @@ config ARCH_EXYNOS
 	select CLKDEV_LOOKUP
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_GPIO
 	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
@@ -873,7 +866,6 @@ config ARCH_U300
 	select COMMON_CLK
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_GPIO
 	select HAVE_TCM
 	select SPARSE_IRQ
 	help
@@ -957,7 +949,6 @@ config ARCH_VT8500_SINGLE
 	select COMMON_CLK
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_GPIO
 	select HAVE_CLK
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 48705c1..bf02471 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -7,7 +7,6 @@ config ARCH_BCM
 	select ARM_GIC
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_GPIO
 	select GENERIC_TIME
 	select GPIO_BCM
 	select SPARSE_IRQ
diff --git a/arch/arm/mach-picoxcell/Kconfig b/arch/arm/mach-picoxcell/Kconfig
index 868796f..13bae78 100644
--- a/arch/arm/mach-picoxcell/Kconfig
+++ b/arch/arm/mach-picoxcell/Kconfig
@@ -7,7 +7,6 @@ config ARCH_PICOXCELL
 	select DW_APB_TIMER
 	select DW_APB_TIMER_OF
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_GPIO
 	select HAVE_TCM
 	select NO_IOPORT
 	select SPARSE_IRQ
diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
index 2ed0b7d..8464497 100644
--- a/arch/arm/mach-vt8500/Kconfig
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -6,7 +6,6 @@ config ARCH_VT8500
 	select CLKDEV_LOOKUP
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_GPIO
 	select HAVE_CLK
 	help
 	  Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
-- 
1.7.9.5
