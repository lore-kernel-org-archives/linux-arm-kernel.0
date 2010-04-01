From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 1 Apr 2010 17:32:18 -0500
Subject: [PATCH] arm: ARCH_REQUIRE_GPIOLIB selects GENERIC_GPIO
Message-ID: <0D753D10438DA54287A00B0270842697636A7E9494@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARCH_REQUIRE_GPIOLIB config option will select GPIOLIB which
in turn will select GENERIC_GPIO.  Because of this, there is no
reason to do the select GENERIC_GPIO in arch/arm/Kconfig for the
architectures that have ARCH_REQUIRE_GPIOLIB.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c5408bf..cdaa337 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -271,7 +271,6 @@ config ARCH_VERSATILE
 
 config ARCH_AT91
 	bool "Atmel AT91"
-	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
 	help
@@ -299,7 +298,6 @@ config ARCH_CLPS711X
 config ARCH_GEMINI
 	bool "Cortina Systems Gemini"
 	select CPU_FA526
-	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support for the Cortina Systems Gemini family SoCs
@@ -320,7 +318,6 @@ config ARCH_EP93XX
 	select CPU_ARM920T
 	select ARM_AMBA
 	select ARM_VIC
-	select GENERIC_GPIO
 	select HAVE_CLK
 	select COMMON_CLKDEV
 	select ARCH_REQUIRE_GPIOLIB
@@ -354,7 +351,6 @@ config ARCH_STMP3XXX
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_GPIO
 	select USB_ARCH_HAS_EHCI
 	help
 	  Support for systems based on the Freescale 3xxx CPUs.
@@ -392,7 +388,6 @@ config ARCH_IOP32X
 	select CPU_XSCALE
 	select PLAT_IOP
 	select PCI
-	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support for Intel's 80219 and IOP32X (XScale) family of
@@ -404,7 +399,6 @@ config ARCH_IOP33X
 	select CPU_XSCALE
 	select PLAT_IOP
 	select PCI
-	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support for Intel's IOP33X (XScale) family of processors.
@@ -453,7 +447,6 @@ config ARCH_L7200
 config ARCH_DOVE
 	bool "Marvell Dove"
 	select PCI
-	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
@@ -465,7 +458,6 @@ config ARCH_KIRKWOOD
 	bool "Marvell Kirkwood"
 	select CPU_FEROCEON
 	select PCI
-	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
@@ -487,7 +479,6 @@ config ARCH_MV78XX0
 	bool "Marvell MV78xx0"
 	select CPU_FEROCEON
 	select PCI
-	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
@@ -501,7 +492,6 @@ config ARCH_ORION5X
 	depends on MMU
 	select CPU_FEROCEON
 	select PCI
-	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
@@ -514,7 +504,6 @@ config ARCH_ORION5X
 config ARCH_MMP
 	bool "Marvell PXA168/910/MMP2"
 	depends on MMU
-	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
 	select COMMON_CLKDEV
@@ -528,7 +517,6 @@ config ARCH_MMP
 config ARCH_KS8695
 	bool "Micrel/Kendin KS8695"
 	select CPU_ARM922T
-	select GENERIC_GPIO
         select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support for Micrel/Kendin KS8695 "Centaur" (ARM922T) based
@@ -551,7 +539,6 @@ config ARCH_W90X900
 	bool "Nuvoton W90X900 CPU"
 	select CPU_ARM926T
 	select ARCH_REQUIRE_GPIOLIB
-	select GENERIC_GPIO
 	select HAVE_CLK
 	select COMMON_CLKDEV
 	select GENERIC_TIME
@@ -587,7 +574,6 @@ config ARCH_PXA
 	depends on MMU
 	select ARCH_MTD_XIP
 	select ARCH_HAS_CPUFREQ
-	select GENERIC_GPIO
 	select HAVE_CLK
 	select COMMON_CLKDEV
 	select ARCH_REQUIRE_GPIOLIB
@@ -636,7 +622,6 @@ config ARCH_SA1100
 	select ARCH_MTD_XIP
 	select ARCH_HAS_CPUFREQ
 	select CPU_FREQ
-	select GENERIC_GPIO
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
@@ -659,7 +644,6 @@ config ARCH_S3C64XX
 	bool "Samsung S3C64XX"
 	select PLAT_SAMSUNG
 	select CPU_V6
-	select GENERIC_GPIO
 	select ARM_VIC
 	select HAVE_CLK
 	select NO_IOPORT
@@ -768,7 +752,6 @@ config ARCH_NOMADIK
 	select COMMON_CLKDEV
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support for the Nomadik platform by ST-Ericsson
@@ -778,7 +761,6 @@ config ARCH_DAVINCI
 	select CPU_ARM926T
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
 	select ZONE_DMA
@@ -791,7 +773,6 @@ config ARCH_DAVINCI
 
 config ARCH_OMAP
 	bool "TI OMAP"
-	select GENERIC_GPIO
 	select HAVE_CLK
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
