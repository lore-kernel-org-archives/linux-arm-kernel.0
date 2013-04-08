From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 08 Apr 2013 16:23:59 +0200
Subject: [PATCH] ARM: imx: remove configs ARCH_MX5 and ARCH_MX51
Message-ID: <1365431039.1830.102.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbols ARCH_MX5 and ARCH_MX51 are unused since v3.3. They
can safely be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested with "git grep" only.

 arch/arm/mach-imx/Kconfig | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 6d9ae09..cbd6942 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -92,12 +92,6 @@ config ARCH_MX25
 config MACH_MX27
 	bool
 
-config ARCH_MX5
-	bool
-
-config ARCH_MX51
-	bool
-
 config ARCH_MX53
 	bool
 
@@ -155,7 +149,6 @@ config SOC_IMX35
 config SOC_IMX5
 	bool
 	select ARCH_HAS_CPUFREQ
-	select ARCH_MX5
 	select ARCH_MXC_IOMUX_V3
 	select COMMON_CLK
 	select CPU_V7
@@ -163,8 +156,6 @@ config SOC_IMX5
 
 config	SOC_IMX51
 	bool
-	select ARCH_MX5
-	select ARCH_MX51
 	select PINCTRL
 	select PINCTRL_IMX51
 	select SOC_IMX5
@@ -787,7 +778,6 @@ comment "Device tree only"
 
 config	SOC_IMX53
 	bool "i.MX53 support"
-	select ARCH_MX5
 	select ARCH_MX53
 	select HAVE_CAN_FLEXCAN if CAN
 	select IMX_HAVE_PLATFORM_IMX2_WDT
-- 
1.7.11.7
