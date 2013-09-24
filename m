From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 24 Sep 2013 19:41:55 +0200
Subject: [PATCH] ARM: drop explicit selection of HAVE_CLK and CLKDEV_LOOKUP
Message-ID: <1380044515-3173-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLKDEV_LOOKUP selects HAVE_CLK and COMMON_CLK selects CLKDEV_LOOKUP. So
all symbols that select at least two of these symbols can be simplified.

For imx, omap2 and ux500 some rearrangements were necessary before the
simplification.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig               | 12 ------------
 arch/arm/mach-highbank/Kconfig |  1 -
 arch/arm/mach-imx/Kconfig      | 10 +---------
 arch/arm/mach-omap2/Kconfig    |  9 +--------
 arch/arm/mach-socfpga/Kconfig  |  1 -
 arch/arm/mach-spear/Kconfig    |  2 --
 arch/arm/mach-tegra/Kconfig    |  2 --
 arch/arm/mach-u300/Kconfig     |  1 -
 arch/arm/mach-ux500/Kconfig    | 29 ++++++++++++-----------------
 arch/arm/mach-vexpress/Kconfig |  2 --
 arch/arm/mach-vt8500/Kconfig   |  1 -
 11 files changed, 14 insertions(+), 56 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3230f4c..66164a0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -360,7 +360,6 @@ config ARCH_AT91
 	bool "Atmel AT91"
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
-	select HAVE_CLK
 	select IRQ_DOMAIN
 	select NEED_MACH_GPIO_H
 	select NEED_MACH_IO_H if PCCARD
@@ -374,7 +373,6 @@ config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
 	select ARCH_REQUIRE_GPIOLIB
 	select AUTO_ZRELADDR
-	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select COMMON_CLK
 	select CPU_ARM720T
@@ -633,7 +631,6 @@ config ARCH_PXA
 config ARCH_MSM
 	bool "Qualcomm MSM"
 	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
 	select CLKSRC_OF if OF
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
@@ -651,7 +648,6 @@ config ARCH_SHMOBILE
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select HAVE_CLK
 	select HAVE_MACH_CLKDEV
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
@@ -708,7 +704,6 @@ config ARCH_S3C24XX
 	select CLKSRC_SAMSUNG_PWM
 	select GENERIC_CLOCKEVENTS
 	select GPIO_SAMSUNG
-	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
@@ -733,7 +728,6 @@ config ARCH_S3C64XX
 	select CPU_V6
 	select GENERIC_CLOCKEVENTS
 	select GPIO_SAMSUNG
-	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_TCM
@@ -756,7 +750,6 @@ config ARCH_S5P64X0
 	select CPU_V6
 	select GENERIC_CLOCKEVENTS
 	select GPIO_SAMSUNG
-	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
@@ -775,7 +768,6 @@ config ARCH_S5PC100
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select GPIO_SAMSUNG
-	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
@@ -795,7 +787,6 @@ config ARCH_S5PV210
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select GPIO_SAMSUNG
-	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
@@ -812,11 +803,9 @@ config ARCH_EXYNOS
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SPARSEMEM_ENABLE
 	select ARM_GIC
-	select CLKDEV_LOOKUP
 	select COMMON_CLK
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
@@ -867,7 +856,6 @@ config ARCH_OMAP1
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
-	select HAVE_CLK
 	select HAVE_IDE
 	select IRQ_DOMAIN
 	select NEED_MACH_IO_H if PCCARD
diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
index 8e8437d..616408d 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -12,7 +12,6 @@ config ARCH_HIGHBANK
 	select ARM_GIC
 	select ARM_TIMER_SP804
 	select CACHE_L2X0
-	select CLKDEV_LOOKUP
 	select COMMON_CLK
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 9f67338..0026a95 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -4,8 +4,8 @@ config ARCH_MXC
 	select ARM_CPU_SUSPEND if PM
 	select ARM_PATCH_PHYS_VIRT
 	select AUTO_ZRELADDR if !ZBOOT_ROM
-	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select COMMON_CLK
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
@@ -92,14 +92,12 @@ config MACH_MX27
 config SOC_IMX1
 	bool
 	select ARCH_MX1
-	select COMMON_CLK
 	select CPU_ARM920T
 	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
 
 config SOC_IMX21
 	bool
-	select COMMON_CLK
 	select CPU_ARM926T
 	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
@@ -108,7 +106,6 @@ config SOC_IMX25
 	bool
 	select ARCH_MX25
 	select ARCH_MXC_IOMUX_V3
-	select COMMON_CLK
 	select CPU_ARM926T
 	select MXC_AVIC
 
@@ -116,7 +113,6 @@ config SOC_IMX27
 	bool
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
-	select COMMON_CLK
 	select CPU_ARM926T
 	select IMX_HAVE_IOMUX_V1
 	select MACH_MX27
@@ -124,7 +120,6 @@ config SOC_IMX27
 
 config SOC_IMX31
 	bool
-	select COMMON_CLK
 	select CPU_V6
 	select IMX_HAVE_PLATFORM_MXC_RNGA
 	select MXC_AVIC
@@ -133,7 +128,6 @@ config SOC_IMX31
 config SOC_IMX35
 	bool
 	select ARCH_MXC_IOMUX_V3
-	select COMMON_CLK
 	select CPU_V6K
 	select HAVE_EPIT
 	select MXC_AVIC
@@ -144,7 +138,6 @@ config SOC_IMX5
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 	select ARCH_MXC_IOMUX_V3
-	select COMMON_CLK
 	select CPU_V7
 	select MXC_TZIC
 
@@ -791,7 +784,6 @@ config SOC_IMX6Q
 	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_775420
 	select ARM_GIC
-	select COMMON_CLK
 	select CPU_V7
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b5fb5f7..c946244 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -8,7 +8,6 @@ config ARCH_OMAP2
 	select CPU_V6
 	select MULTI_IRQ_HANDLER
 	select SOC_HAS_OMAP2_SDRC
-	select COMMON_CLK
 
 config ARCH_OMAP3
 	bool "TI OMAP3"
@@ -22,7 +21,6 @@ config ARCH_OMAP3
 	select PM_OPP if PM
 	select PM_RUNTIME if CPU_IDLE
 	select SOC_HAS_OMAP2_SDRC
-	select COMMON_CLK
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 
 config ARCH_OMAP4
@@ -45,7 +43,6 @@ config ARCH_OMAP4
 	select PM_OPP if PM
 	select PM_RUNTIME if CPU_IDLE
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
-	select COMMON_CLK
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
 
@@ -59,7 +56,6 @@ config SOC_OMAP5
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if LOCAL_TIMERS
 	select HAVE_SMP
-	select COMMON_CLK
 	select HAVE_ARM_ARCH_TIMER
 	select ARM_ERRATA_798181 if SMP
 
@@ -70,7 +66,6 @@ config SOC_AM33XX
 	select ARM_CPU_SUSPEND if PM
 	select CPU_V7
 	select MULTI_IRQ_HANDLER
-	select COMMON_CLK
 
 config SOC_AM43XX
 	bool "TI AM43x"
@@ -79,7 +74,6 @@ config SOC_AM43XX
 	select ARCH_OMAP2PLUS
 	select MULTI_IRQ_HANDLER
 	select ARM_GIC
-	select COMMON_CLK
 	select MACH_OMAP_GENERIC
 
 config ARCH_OMAP2PLUS
@@ -89,11 +83,10 @@ config ARCH_OMAP2PLUS
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_OMAP
 	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
-	select HAVE_CLK
 	select OMAP_DM_TIMER
 	select PINCTRL
 	select PROC_DEVICETREE if PROC_FS
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index dd86db4..037100a 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -4,7 +4,6 @@ config ARCH_SOCFPGA
 	select ARM_AMBA
 	select ARM_GIC
 	select CACHE_L2X0
-	select CLKDEV_LOOKUP
 	select COMMON_CLK
 	select CPU_V7
 	select DW_APB_TIMER_OF
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index df0d59a..ac1710e6 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -7,11 +7,9 @@ menuconfig PLAT_SPEAR
 	default PLAT_SPEAR_SINGLE
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
-	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK
 
 if PLAT_SPEAR
 
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 67a76f2..0c2f44a 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -3,7 +3,6 @@ config ARCH_TEGRA
 	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
-	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	select COMMON_CLK
@@ -11,7 +10,6 @@ config ARCH_TEGRA
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select HAVE_CLK
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	select MIGHT_HAVE_PCI
diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index a165986..8e23071 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -5,7 +5,6 @@ config ARCH_U300
 	select ARM_AMBA
 	select ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
-	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	select COMMON_CLK
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 99a28d6..c67f8ad 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -1,37 +1,32 @@
 config ARCH_U8500
 	bool "ST-Ericsson U8500 Series" if ARCH_MULTI_V7
 	depends on MMU
+	select AB8500_CORE
+	select ABX500_CORE
 	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
-	select CLKDEV_LOOKUP
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369 if SMP
+	select ARM_GIC
+	select CACHE_L2X0
+	select CLKSRC_NOMADIK_MTU
+	select COMMON_CLK
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
+	select PINCTRL
+	select PINCTRL_ABX500
+	select PINCTRL_NOMADIK
+	select PL310_ERRATA_753970 if CACHE_PL310
 	help
 	  Support for ST-Ericsson's Ux500 architecture
 
 if ARCH_U8500
 
-config UX500_SOC_COMMON
-	bool
-	default y
-	select ABX500_CORE
-	select AB8500_CORE
-	select ARM_ERRATA_754322
-	select ARM_ERRATA_764369 if SMP
-	select ARM_GIC
-	select CACHE_L2X0
-	select CLKSRC_NOMADIK_MTU
-	select COMMON_CLK
-	select PINCTRL
-	select PINCTRL_NOMADIK
-	select PINCTRL_ABX500
-	select PL310_ERRATA_753970 if CACHE_PL310
-
 config UX500_SOC_DB8500
 	bool
 	select CPU_FREQ_TABLE if CPU_FREQ
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 3657954..d7e7422 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -4,14 +4,12 @@ config ARCH_VEXPRESS
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_TIMER_SP804
-	select CLKDEV_LOOKUP
 	select COMMON_CLK
 	select COMMON_CLK_VERSATILE
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select HAVE_CLK
 	select HAVE_PATA_PLATFORM
 	select HAVE_SMP
 	select ICST
diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
index 9b25293..927be93 100644
--- a/arch/arm/mach-vt8500/Kconfig
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -5,7 +5,6 @@ config ARCH_VT8500
 	select CLKDEV_LOOKUP
 	select CLKSRC_OF
 	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK
 	select VT8500_TIMER
 	select PINCTRL
 	help
-- 
1.8.4.rc3
