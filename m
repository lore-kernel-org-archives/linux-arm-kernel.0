From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Sep 2015 17:59:31 +0900
Subject: [PATCH 15/21] ARM: shmobile: remove ARCH_SHMOBILE_LEGACY option
In-Reply-To: <cover.1442478814.git.horms+renesas@verge.net.au>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
Message-ID: <36d6c9280b7f7c895c124ecf918ee5bda3c52ccd.1442478814.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

With Bock-W, the last legacy platform has been removed.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Kconfig               | 26 +-------------------------
 arch/arm/Kconfig.debug         |  3 +--
 arch/arm/mach-shmobile/Kconfig | 23 -----------------------
 3 files changed, 2 insertions(+), 50 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 72ad724c67ae..471a3670cd3e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -621,28 +621,6 @@ config ARCH_PXA
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
-config ARCH_SHMOBILE_LEGACY
-	bool "Renesas ARM SoCs (non-multiplatform)"
-	select ARCH_SHMOBILE
-	select ARM_PATCH_PHYS_VIRT if MMU
-	select CLKDEV_LOOKUP
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
-	select MULTI_IRQ_HANDLER
-	select NO_IOPORT_MAP
-	select PINCTRL
-	select PM_GENERIC_DOMAINS if PM
-	select SH_CLK_CPG
-	select SPARSE_IRQ
-	help
-	  Support for Renesas ARM SoC platforms using a non-multiplatform
-	  kernel. This includes the SH-Mobile, R-Mobile, EMMA-Mobile, R-Car
-	  and RZ families.
-
 config ARCH_RPC
 	bool "RiscPC"
 	select ARCH_ACORN
@@ -1534,7 +1512,6 @@ config HZ_FIXED
 	default 200 if ARCH_EBSA110 || ARCH_S3C24XX || \
 		ARCH_S5PV210 || ARCH_EXYNOS4
 	default 128 if SOC_AT91RM9200
-	default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE_LEGACY
 	default 0
 
 choice
@@ -1752,8 +1729,7 @@ config ARM_MODULE_PLTS
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
-	int "Maximum zone order" if ARCH_SHMOBILE_LEGACY
-	range 11 64 if ARCH_SHMOBILE_LEGACY
+	int "Maximum zone order"
 	default "12" if SOC_AM33XX
 	default "9" if SA1111 || ARCH_EFM32
 	default "11"
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0cfd7f947f6b..40a3c25c1e0d 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1621,8 +1621,7 @@ config DEBUG_UNCOMPRESS
 config UNCOMPRESS_INCLUDE
 	string
 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
-					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M || \
-					ARCH_SHMOBILE_LEGACY
+					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 61a59b18e9d6..7f2e05304d3d 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -99,29 +99,6 @@ config ARCH_SH73A0
 comment "Renesas ARM SoCs System Configuration"
 endif
 
-if ARCH_SHMOBILE_LEGACY
-
-comment "Renesas ARM SoCs System Type"
-
-config ARCH_R8A7779
-	bool "R-Car H1 (R8A77790)"
-	select ARCH_RCAR_GEN1
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_GIC
-
-comment "Renesas ARM SoCs System Configuration"
-
-config CPU_HAS_INTEVT
-        bool
-	default y
-
-config SH_CLK_CPG
-	bool
-
-source "drivers/sh/Kconfig"
-
-endif
-
 if ARCH_SHMOBILE
 
 menu "Timer and clock configuration"
-- 
2.1.4
