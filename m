From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 22 Oct 2009 22:01:26 +0200
Subject: [PATCH 2/2] arm: Kconfig SMP simplification
In-Reply-To: <1256241686-28647-1-git-send-email-plagnioj@jcrosoft.com>
References: <1256241686-28647-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1256241686-28647-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

instead of add depend on at SMP config level introduce HAVE_SMP config
and select it at machine or arch level to specify the ability to enable SMP
support

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/Kconfig               |    6 ++++--
 arch/arm/mach-realview/Kconfig |    4 ++++
 arch/arm/plat-omap/Kconfig     |    1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index beb1340..0539fbe 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -156,6 +156,9 @@ config FIQ
 config ARCH_MTD_XIP
 	bool
 
+config HAVE_SMP
+	bool
+
 config GENERIC_HARDIRQS_NO__DO_IRQ
 	def_bool y
 
@@ -954,8 +957,7 @@ source "kernel/time/Kconfig"
 
 config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
-		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4)
+	depends on EXPERIMENTAL && HAVE_SMP
 	depends on GENERIC_CLOCKEVENTS
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU if (ARCH_REALVIEW || ARCH_OMAP4)
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index dfc9b0b..acf23b5 100644
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
 	help
 	  Include support for the ARM(R) RealView PBX platform.
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 64b3f52..5e00c09 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -27,6 +27,7 @@ config ARCH_OMAP4
 	bool "TI OMAP4"
 	select CPU_V7
 	select ARM_GIC
+	select HAVE_SMP
 
 endchoice
 
-- 
1.6.3.1
