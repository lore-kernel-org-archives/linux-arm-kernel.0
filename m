From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Wed, 21 Nov 2018 21:30:34 +0300
Subject: [RFC PATCH v3 01/17] ARM: add CONFIG_ARCH_SUNXI_V7 for differentiate
 ARMv5/v7 Allwinner SoCs
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Message-ID: <267ffcf3b91930a82f20d93e1fad1fceaf8b9b0e.1542824904.git.mesihkilinc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner also has some ARMv5 SoCs.

In order to add support for them, add a CONFIG_ARCH_SUNXI_V7 bool config
which is selected when a ARMv7 soc is selected, and make CONFIG_ARCH_SUNXI
a common option which is selected by both V7 and V5 sunxi option.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index d9c8ecf..7e5f173 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -6,31 +6,38 @@ menuconfig ARCH_SUNXI
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB
 	select PINCTRL
-	select PM_OPP
 	select SUN4I_TIMER
 	select RESET_CONTROLLER
+	help
+	  Support for Allwinner ARM-based family of processors
 
 if ARCH_SUNXI
 
+if ARCH_MULTI_V7
+
+config ARCH_SUNXI_V7
+	bool
+	select PM_OPP
+
 config MACH_SUN4I
 	bool "Allwinner A10 (sun4i) SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 
 config MACH_SUN5I
 	bool "Allwinner A10s / A13 (sun5i) SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 	select SUN5I_HSTIMER
 
 config MACH_SUN6I
 	bool "Allwinner A31 (sun6i) SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
 	select SUN5I_HSTIMER
 
 config MACH_SUN7I
 	bool "Allwinner A20 (sun7i) SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 	select ARM_GIC
 	select ARM_PSCI
 	select ARCH_SUPPORTS_BIG_ENDIAN
@@ -39,13 +46,13 @@ config MACH_SUN7I
 
 config MACH_SUN8I
 	bool "Allwinner sun8i Family SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
 
 config MACH_SUN9I
 	bool "Allwinner (sun9i) SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 	select ARM_GIC
 
 config ARCH_SUNXI_MC_SMP
@@ -56,3 +63,5 @@ config ARCH_SUNXI_MC_SMP
 	select ARM_CPU_SUSPEND
 
 endif
+
+endif
-- 
2.7.4
