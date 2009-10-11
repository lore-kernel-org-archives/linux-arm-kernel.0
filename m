From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Mon, 12 Oct 2009 03:58:02 +0530
Subject: [PATCH v3 5/7] [ARM]: U8500 integrate to ARM architecture
Message-ID: <1255300082.21542.413.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

This hooks the U8500 support into the ARM kbuild
system. This integration also enables SMP and its
helper funtions for u8500 platform

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
---
 arch/arm/Kconfig  |   19 +++++++++++++++----
 arch/arm/Makefile |    1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..459f1ce 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -702,6 +702,15 @@ config ARCH_BCMRING
 	help
 	  Support for Broadcom's BCMRing platform.
 
+config ARCH_U8500
+	bool "ST-Ericsson U8500 Series"
+	select ARM_AMBA
+	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
+	select COMMON_CLKDEV
+	help
+	  Include support for ST-Ericsson's Cortex-A9 Platform.
+
 endchoice
 
 source "arch/arm/mach-clps711x/Kconfig"
@@ -800,6 +809,8 @@ source "arch/arm/mach-msm/Kconfig"
 
 source "arch/arm/mach-u300/Kconfig"
 
+source "arch/arm/mach-ux500/Kconfig"
+
 source "arch/arm/mach-w90x900/Kconfig"
 
 source "arch/arm/mach-bcmring/Kconfig"
@@ -955,10 +966,10 @@ source "kernel/time/Kconfig"
 config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
-		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4)
+		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || ARCH_U8500)
 	depends on GENERIC_CLOCKEVENTS
 	select USE_GENERIC_SMP_HELPERS
-	select HAVE_ARM_SCU if (ARCH_REALVIEW || ARCH_OMAP4)
+	select HAVE_ARM_SCU if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500)
 	help
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
@@ -1027,9 +1038,9 @@ config HOTPLUG_CPU
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || \
-		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4)
+		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || ARCH_U8500)
 	default y
-	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_OMAP4)
+	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a73caaf..aef2404 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -166,6 +166,7 @@ machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_STMP378X)		:= stmp378x
 machine-$(CONFIG_ARCH_STMP37XX)		:= stmp37xx
 machine-$(CONFIG_ARCH_U300)		:= u300
+machine-$(CONFIG_ARCH_U8500)		:= ux500
 machine-$(CONFIG_ARCH_VERSATILE)	:= versatile
 machine-$(CONFIG_ARCH_W90X900)		:= w90x900
 machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
-- 
1.6.3.GIT
