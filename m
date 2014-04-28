From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 16:03:20 -0700
Subject: [PATCH v2] ARM: sunxi: Split the various SoCs support in Kconfig
Message-ID: <1398726200-30362-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow to better isolate various options, and reduce the overall
kernel size if we're interested in only one of the SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---

Changes from v1:
  - Changed from config to menuconfig
  - Enabled the SoCs variants by default if the machine is selected

 arch/arm/mach-sunxi/Kconfig | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index b57d7d53b9d3..3aff96602868 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,14 +1,37 @@
-config ARCH_SUNXI
-	bool "Allwinner A1X SOCs" if ARCH_MULTI_V7
-	select ARCH_HAS_RESET_CONTROLLER
+menuconfig ARCH_SUNXI
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
+config MACH_SUN4I
+	bool "Allwinner A10 (sun4i) SoCs support"
+	default ARCH_SUNXI
+
+config MACH_SUN5I
+	bool "Allwinner A10s / A13 (sun5i) SoCs support"
+	default ARCH_SUNXI
+	select SUN5I_HSTIMER
+
+config MACH_SUN6I
+	bool "Allwinner A31 (sun6i) SoCs support"
+	default ARCH_SUNXI
+	select ARCH_HAS_RESET_CONTROLLER
+	select ARM_GIC
+	select RESET_CONTROLLER
+	select SUN5I_HSTIMER
+
+config MACH_SUN7I
+	bool "Allwinner A20 (sun7i) SoCs support"
+	default ARCH_SUNXI
+	select ARM_GIC
+	select ARM_PSCI
+	select HAVE_ARM_ARCH_TIMER
 	select SUN5I_HSTIMER
+
+endif
-- 
1.9.1
