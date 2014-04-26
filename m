From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 26 Apr 2014 18:16:53 +0200
Subject: [PATCH 1/2] ARM: sunxi: Split the various SoCs support in Kconfig
In-Reply-To: <1398529014-1152-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1398529014-1152-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1398529014-1152-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow to better isolate various options, and reduce the overall
kernel size if we're interested in only one of the SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/Kconfig | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index b57d7d53b9d3..23575010ff49 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,14 +1,37 @@
 config ARCH_SUNXI
-	bool "Allwinner A1X SOCs" if ARCH_MULTI_V7
-	select ARCH_HAS_RESET_CONTROLLER
+	bool "Allwinner SoCs" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
-	select ARM_GIC
-	select ARM_PSCI
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
-	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL
 	select PINCTRL_SUNXI
-	select RESET_CONTROLLER
 	select SUN4I_TIMER
+
+if ARCH_SUNXI
+
+menu "Allwinner SoCs variants"
+
+config MACH_SUN4I
+	bool "Allwinner A10 (sun4i) SoCs support"
+
+config MACH_SUN5I
+	bool "Allwinner A10s / A13 (sun5i) SoCs support"
+	select SUN5I_HSTIMER
+
+config MACH_SUN6I
+	bool "Allwinner A31 (sun6i) SoCs support"
+	select ARCH_HAS_RESET_CONTROLLER
+	select ARM_GIC
+	select RESET_CONTROLLER
+	select SUN5I_HSTIMER
+
+config MACH_SUN7I
+	bool "Allwinner A20 (sun7i) SoCs support"
+	select ARM_GIC
+	select ARM_PSCI
+	select HAVE_ARM_ARCH_TIMER
 	select SUN5I_HSTIMER
+
+endmenu
+
+endif
-- 
1.9.1
