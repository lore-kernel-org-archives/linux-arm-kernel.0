From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Sat, 24 Oct 2015 01:01:51 +0530
Subject: [PATCH v4 02/12] arm64: Rename FSL LS2085A SoC support code to LS2080A
In-Reply-To: <1445628721-10483-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1445628721-10483-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1445628721-10483-3-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Freescale is renaming the LS2085A SoC to LS2080A. This patch
addresses the same.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt      |    4 ++--
 arch/arm64/boot/dts/freescale/Makefile             |    2 +-
 .../{fsl-ls2085a-simu.dts => fsl-ls2080a-simu.dts} |   10 +++++-----
 .../{fsl-ls2085a.dtsi => fsl-ls2080a.dtsi}         |    6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)
 rename arch/arm64/boot/dts/freescale/{fsl-ls2085a-simu.dts => fsl-ls2080a-simu.dts} (90%)
 rename arch/arm64/boot/dts/freescale/{fsl-ls2085a.dtsi => fsl-ls2080a.dtsi} (97%)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 744b4de..53f229a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -131,7 +131,7 @@ Example:
 Freescale ARMv8 based Layerscape SoC family Device Tree Bindings
 ----------------------------------------------------------------
 
-LS2085A ARMv8 based Simulator model
+LS2080A ARMv8 based Simulator model
 Required root node properties:
-    - compatible = "fsl,ls2085a-simu", "fsl,ls2085a";
+    - compatible = "fsl,ls2080a-simu", "fsl,ls2080a";
 
diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index fc6fca3c..932001a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -1,4 +1,4 @@
-dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2085a-simu.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
  
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
similarity index 90%
rename from arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts
rename to arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
index 82e2a6f..33d6d0c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
@@ -1,7 +1,7 @@
 /*
- * Device Tree file for Freescale LS2085a software Simulator model
+ * Device Tree file for Freescale LS2080a software Simulator model
  *
- * Copyright (C) 2014, Freescale Semiconductor
+ * Copyright (C) 2014-2015, Freescale Semiconductor
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
index e281ceb..9597edf 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -1,7 +1,7 @@
 /*
- * Device Tree Include file for Freescale Layerscape-2085A family SoC.
+ * Device Tree Include file for Freescale Layerscape-2080A family SoC.
  *
- * Copyright (C) 2014, Freescale Semiconductor
+ * Copyright (C) 2014-2015, Freescale Semiconductor
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
-- 
1.7.9.5
