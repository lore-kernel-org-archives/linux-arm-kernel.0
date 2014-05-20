From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 May 2014 16:45:20 +0800
Subject: [PATCH 02/20] ARM: imx5: move SOC_IMX5 and SOC_IMX51 into 'Device
 tree only'
In-Reply-To: <1400575538-21136-1-git-send-email-shawn.guo@freescale.com>
References: <1400575538-21136-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1400575538-21136-3-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After moving SOC_IMX51 support over to device tree, all i.MX5 support
becomes device tree only now.  So options SOC_IMX5 and SOC_IMX51 can
just be under 'Device tree only'.

While at it, 'select ARCH_MXC_IOMUX_V3' is dropped, since it's only
needed by non-DT build before.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/Kconfig | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index a6ee115..c6a5e37 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -122,19 +122,6 @@ config SOC_IMX35
 	select PINCTRL_IMX35
 	select SMP_ON_UP if SMP
 
-config SOC_IMX5
-	bool
-	select ARCH_HAS_CPUFREQ
-	select ARCH_HAS_OPP
-	select ARCH_MXC_IOMUX_V3
-	select HAVE_IMX_SRC
-	select MXC_TZIC
-
-config	SOC_IMX51
-	bool
-	select PINCTRL_IMX51
-	select SOC_IMX5
-
 if ARCH_MULTI_V4T
 
 comment "MX1 platforms:"
@@ -704,6 +691,18 @@ if ARCH_MULTI_V7
 
 comment "Device tree only"
 
+config SOC_IMX5
+	bool
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
+	select HAVE_IMX_SRC
+	select MXC_TZIC
+
+config	SOC_IMX51
+	bool
+	select PINCTRL_IMX51
+	select SOC_IMX5
+
 config	SOC_IMX50
 	bool "i.MX50 support"
 	select PINCTRL_IMX50
-- 
1.8.3.2
