From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 22 Jun 2010 06:52:59 -0700
Subject: [PATCH] arm: kconfig: add HAVE_SMP
Message-ID: <1277214779-14227-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This replaces the board listing for SMP with a HAVE_SMP
config option which can be selected when the sub-architecture
is selected.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/Kconfig               |    8 +++++---
 arch/arm/mach-realview/Kconfig |    4 ++++
 arch/arm/mach-vexpress/Kconfig |    1 +
 arch/arm/plat-omap/Kconfig     |    1 +
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1f254bd..4cf10d5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -748,6 +748,7 @@ config ARCH_U8500
 	select GENERIC_CLOCKEVENTS
 	select COMMON_CLKDEV
 	select ARCH_REQUIRE_GPIOLIB
+	select HAVE_SMP
 	help
 	  Support for ST-Ericsson's Ux500 architecture
 
@@ -1095,11 +1096,12 @@ menu "Kernel Features"
 
 source "kernel/time/Kconfig"
 
+config HAVE_SMP
+	bool
+
 config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
-		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 ||\
-		 ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
+	depends on EXPERIMENTAL && HAVE_SMP
 	depends on GENERIC_CLOCKEVENTS
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index ee5e392..fcfdfb7 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -11,6 +11,7 @@ config REALVIEW_EB_A9MP
 	bool "Support Multicore Cortex-A9"
 	depends on MACH_REALVIEW_EB
 	select CPU_V7
+	select HAVE_SMP
 	help
 	  Enable support for the Cortex-A9MPCore tile on the Realview platform.
 
@@ -18,6 +19,7 @@ config REALVIEW_EB_ARM11MP
 	bool "Support ARM11MPCore tile"
 	depends on MACH_REALVIEW_EB
 	select CPU_V6
+	select HAVE_SMP
 	help
 	  Enable support for the ARM11MPCore tile on the Realview platform.
 
@@ -35,6 +37,7 @@ config MACH_REALVIEW_PB11MP
 	select CPU_V6
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
+	select HAVE_SMP
 	help
 	  Include support for the ARM(R) RealView MPCore Platform Baseboard.
 	  PB11MPCore is a platform with an on-board ARM11MPCore and has
@@ -70,6 +73,7 @@ config MACH_REALVIEW_PBX
 	bool "Support RealView/PBX platform"
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
+	select HAVE_SMP
 	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
 	select ZONE_DMA if SPARSEMEM
 	help
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 3f19b66..a20fa2f 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -5,5 +5,6 @@ config ARCH_VEXPRESS_CA9X4
 	bool "Versatile Express Cortex-A9x4 tile"
 	select CPU_V7
 	select ARM_GIC
+	select HAVE_SMP
 
 endmenu
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 78b49a6..6a2636a 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -38,6 +38,7 @@ config ARCH_OMAP4
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
 	select ARM_GIC
+	select HAVE_SMP
 
 endchoice
 
-- 
1.7.0.4
