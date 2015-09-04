From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Fri, 4 Sep 2015 12:27:43 +0530
Subject: [PATCH v2 01/10] arm64: Use generic Layerscape SoC family naming &
 rename LS2085A to LS2080A
In-Reply-To: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1441349872-4560-2-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Freescale will be a churning out a host of ARMv8 based SoCs which
will be based on a similar overall SoC architecture. So, this patch
converts the existing infrastructure in the arm64/dts, arm64/Kconfig
and arm64/configs to use the generic convention ARCH_LAYERSCAPE
in place of the more specific FSL_LS2085A, to save code duplication
later-on.

Also Freescale is renaming LS2085A to LS2080A.

This patch addresses the above two points.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt      |    8 ++++----
 arch/arm64/Kconfig                                 |    6 +++---
 arch/arm64/boot/dts/freescale/Makefile             |    2 +-
 .../{fsl-ls2085a-simu.dts => fsl-ls2080a-simu.dts} |   10 +++++-----
 .../{fsl-ls2085a.dtsi => fsl-ls2080a.dtsi}         |    6 +++---
 arch/arm64/configs/defconfig                       |    2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)
 rename arch/arm64/boot/dts/freescale/{fsl-ls2085a-simu.dts => fsl-ls2080a-simu.dts} (90%)
 rename arch/arm64/boot/dts/freescale/{fsl-ls2085a.dtsi => fsl-ls2080a.dtsi} (97%)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 2a3ba73..53f229a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -128,10 +128,10 @@ Example:
 		reg = <0x0 0x1ee0000 0x0 0x10000>;
 	};
 
-Freescale LS2085A SoC Device Tree Bindings
-------------------------------------------
+Freescale ARMv8 based Layerscape SoC family Device Tree Bindings
+----------------------------------------------------------------
 
-LS2085A ARMv8 based Simulator model
+LS2080A ARMv8 based Simulator model
 Required root node properties:
-    - compatible = "fsl,ls2085a-simu", "fsl,ls2085a";
+    - compatible = "fsl,ls2080a-simu", "fsl,ls2080a";
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 318175f..65b335b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -179,10 +179,10 @@ config ARCH_EXYNOS7
 	help
 	  This enables support for Samsung Exynos7 SoC family
 
-config ARCH_FSL_LS2085A
-	bool "Freescale LS2085A SOC"
+config ARCH_LAYERSCAPE
+	bool "ARMv8 based Freescale Layerscape SoC family"
 	help
-	  This enables support for Freescale LS2085A SOC.
+	  This enables support for Freescale Layerscape SoC family.
 
 config ARCH_HISI
 	bool "Hisilicon SoC Family"
diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 4f2de3e7..932001a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -1,4 +1,4 @@
-dtb-$(CONFIG_ARCH_FSL_LS2085A) += fsl-ls2085a-simu.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
  
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
similarity index 90%
rename from arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts
rename to arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
index 82e2a6f..cf45d38 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
@@ -1,7 +1,7 @@
 /*
- * Device Tree file for Freescale LS2085a software Simulator model
+ * Device Tree file for Freescale LS2080a software Simulator model
  *
- * Copyright (C) 2014, Freescale Semiconductor
+ * Copyright (C) 2014-15, Freescale Semiconductor
  *
  * Bhupesh Sharma <bhupesh.sharma@freescale.com>
  *
@@ -51,11 +51,11 @@
 
 /dts-v1/;
 
-/include/ "fsl-ls2085a.dtsi"
+/include/ "fsl-ls2080a.dtsi"
 
 / {
-	model = "Freescale Layerscape 2085a software Simulator model";
-	compatible = "fsl,ls2085a-simu", "fsl,ls2085a";
+	model = "Freescale Layerscape 2080a software Simulator model";
+	compatible = "fsl,ls2080a-simu", "fsl,ls2080a";
 
 	ethernet at 2210000 {
 		compatible = "smsc,lan91c111";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
similarity index 97%
rename from arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
rename to arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index e281ceb..333d942 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -1,7 +1,7 @@
 /*
- * Device Tree Include file for Freescale Layerscape-2085A family SoC.
+ * Device Tree Include file for Freescale Layerscape-2080A family SoC.
  *
- * Copyright (C) 2014, Freescale Semiconductor
+ * Copyright (C) 2014-15, Freescale Semiconductor
  *
  * Bhupesh Sharma <bhupesh.sharma@freescale.com>
  *
@@ -50,7 +50,7 @@
  */
 
 / {
-	compatible = "fsl,ls2085a";
+	compatible = "fsl,ls2080a";
 	interrupt-parent = <&gic>;
 	#address-cells = <2>;
 	#size-cells = <2>;
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4e17e7e..fa6aa9f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -32,7 +32,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 CONFIG_ARCH_EXYNOS7=y
-CONFIG_ARCH_FSL_LS2085A=y
+CONFIG_ARCH_LAYERSCAPE=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_SEATTLE=y
-- 
1.7.9.5
