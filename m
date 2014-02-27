From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 27 Feb 2014 16:42:43 +0800
Subject: [PATCH 1/3] ARM: imx6: introduce CONFIG_SOC_IMX6 for i.MX6 common
 stuff
Message-ID: <1393490565-26387-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6 SoCs have something in common, so let's introduce
CONFIG_SOC_IMX6 for those stuff.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Kconfig |   35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index d75d168..e45062d 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -786,46 +786,39 @@ config	SOC_IMX53
 	help
 	  This enables support for Freescale i.MX53 processor.
 
-config SOC_IMX6Q
-	bool "i.MX6 Quad/DualLite support"
+config SOC_IMX6
+	bool
 	select ARM_ERRATA_754322
-	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_775420
 	select ARM_GIC
 	select CPU_V7
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
 	select HAVE_IMX_ANATOP
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
-	select HAVE_SMP
 	select MFD_SYSCON
-	select MIGHT_HAVE_PCI
-	select PCI_DOMAINS if PCI
-	select PINCTRL_IMX6Q
 	select PL310_ERRATA_588369 if CACHE_PL310
 	select PL310_ERRATA_727915 if CACHE_PL310
 	select PL310_ERRATA_769419 if CACHE_PL310
 
+config SOC_IMX6Q
+	bool "i.MX6 Quad/DualLite support"
+	select ARM_ERRATA_764369 if SMP
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select HAVE_SMP
+	select MIGHT_HAVE_PCI
+	select PCI_DOMAINS if PCI
+	select PINCTRL_IMX6Q
+	select SOC_IMX6
+
 	help
 	  This enables support for Freescale i.MX6 Quad processor.
 
 config SOC_IMX6SL
 	bool "i.MX6 SoloLite support"
-	select ARM_ERRATA_754322
-	select ARM_ERRATA_775420
-	select ARM_GIC
-	select CPU_V7
-	select HAVE_IMX_ANATOP
-	select HAVE_IMX_GPC
-	select HAVE_IMX_MMDC
-	select HAVE_IMX_SRC
-	select MFD_SYSCON
 	select PINCTRL_IMX6SL
-	select PL310_ERRATA_588369 if CACHE_PL310
-	select PL310_ERRATA_727915 if CACHE_PL310
-	select PL310_ERRATA_769419 if CACHE_PL310
+	select SOC_IMX6
 
 	help
 	  This enables support for Freescale i.MX6 SoloLite processor.
-- 
1.7.9.5
