From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  8 Jul 2013 14:58:36 -0300
Subject: [PATCH 1/3] ARM: imx: Select CACHE_L2X0
Message-ID: <1373306318-15604-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Select CACHE_L2X0 for mx31/35/51/53/6q/6sl.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index f546560..f864af2 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -122,6 +122,7 @@ config SOC_IMX27
 
 config SOC_IMX31
 	bool
+	select CACHE_L2X0
 	select COMMON_CLK
 	select CPU_V6
 	select IMX_HAVE_PLATFORM_MXC_RNGA
@@ -131,6 +132,7 @@ config SOC_IMX31
 config SOC_IMX35
 	bool
 	select ARCH_MXC_IOMUX_V3
+	select CACHE_L2X0
 	select COMMON_CLK
 	select CPU_V6K
 	select HAVE_EPIT
@@ -142,6 +144,7 @@ config SOC_IMX5
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 	select ARCH_MXC_IOMUX_V3
+	select CACHE_L2X0
 	select COMMON_CLK
 	select CPU_V7
 	select MXC_TZIC
@@ -785,6 +788,7 @@ config SOC_IMX6Q
 	bool "i.MX6 Quad/DualLite support"
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
+	select CACHE_L2X0
 	select ARM_CPU_SUSPEND if PM
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
@@ -815,6 +819,7 @@ config SOC_IMX6SL
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
 	select ARM_GIC
+	select CACHE_L2X0
 	select CPU_V7
 	select HAVE_IMX_ANATOP
 	select HAVE_IMX_GPC
-- 
1.8.1.2
