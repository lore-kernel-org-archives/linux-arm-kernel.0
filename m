From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:42:34 +0100
Subject: [PATCH 02/11] ARM: sunxi: always select RESET_CONTROLLER
In-Reply-To: <1423770163-583064-1-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
Message-ID: <1423770163-583064-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A lot of drivers for mach-sunxi depend on RESET_CONTROLLER. While
this is selected for the drivers that have it, we keep running
into build errors in drivers that are used on both the SoCs with
and without a reset controller.

This patch moves the select statements into the common sunxi
Kconfig option, which solves multiple such problems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/Kconfig | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index a77604fbaf25..8f9f5abf5674 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,9 +1,11 @@
 menuconfig ARCH_SUNXI
 	bool "Allwinner SoCs" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
+	select RESET_CONTROLLER
 	select SUN4I_TIMER
 
 if ARCH_SUNXI
@@ -20,10 +22,8 @@ config MACH_SUN5I
 config MACH_SUN6I
 	bool "Allwinner A31 (sun6i) SoCs support"
 	default ARCH_SUNXI
-	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
-	select RESET_CONTROLLER
 	select SUN5I_HSTIMER
 
 config MACH_SUN7I
@@ -37,16 +37,12 @@ config MACH_SUN7I
 config MACH_SUN8I
 	bool "Allwinner A23 (sun8i) SoCs support"
 	default ARCH_SUNXI
-	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
-	select RESET_CONTROLLER
 
 config MACH_SUN9I
 	bool "Allwinner (sun9i) SoCs support"
 	default ARCH_SUNXI
-	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_GIC
-	select RESET_CONTROLLER
 
 endif
-- 
2.1.0.rc2
