From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Mar 2018 13:20:42 -0300
Subject: [PATCH v2 1/2] Revert "arm64: dts: fsl: fix ifc simple-bus unit
 address format warnings"
Message-ID: <1522081243-30871-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

This reverts commit f81d7af7957539b7808961f929f945381530acb9.

As explained by Rob Herring:

"This "fix" is wrong. Memory controllers with chip selects should have
the chip select in the unit-address. The correct fix here is you should
drop "simple-bus"."

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Only send the revert patches for now.

 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  | 6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  | 6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts  | 6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts  | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 6 +++---
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index 3a09297..6341281 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -84,19 +84,19 @@
 		  0x2 0x0 0x0 0x7fb00000 0x00000100>;
 	status = "okay";
 
-	nor at 0 {
+	nor at 0,0 {
 		compatible = "cfi-flash";
 		reg = <0x0 0x0 0x8000000>;
 		bank-width = <2>;
 		device-width = <1>;
 	};
 
-	nand at 100000000 {
+	nand at 1,0 {
 		compatible = "fsl,ifc-nand";
 		reg = <0x1 0x0 0x10000>;
 	};
 
-	fpga: board-control at 200000000 {
+	fpga: board-control at 2,0 {
 		compatible = "fsl,ls1043aqds-fpga", "fsl,fpga-qixis";
 		reg = <0x2 0x0 0x0000100>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index 0a82bf9..3dc0c8e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -97,7 +97,7 @@
 		  0x1 0x0 0x0 0x7e800000 0x00010000
 		  0x2 0x0 0x0 0x7fb00000 0x00000100>;
 
-		nor at 0 {
+		nor at 0,0 {
 			compatible = "cfi-flash";
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -106,14 +106,14 @@
 			device-width = <1>;
 		};
 
-		nand at 100000000 {
+		nand at 1,0 {
 			compatible = "fsl,ifc-nand";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			reg = <0x1 0x0 0x10000>;
 		};
 
-		cpld: board-control at 200000000 {
+		cpld: board-control at 2,0 {
 			compatible = "fsl,ls1043ardb-cpld";
 			reg = <0x2 0x0 0x0000100>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index 410dc61..434383b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -175,19 +175,19 @@
 		  0x2 0x0 0x0 0x7fb00000 0x00000100>;
 	status = "okay";
 
-	nor at 0 {
+	nor at 0,0 {
 		compatible = "cfi-flash";
 		reg = <0x0 0x0 0x8000000>;
 		bank-width = <2>;
 		device-width = <1>;
 	};
 
-	nand at 100000000 {
+	nand at 1,0 {
 		compatible = "fsl,ifc-nand";
 		reg = <0x1 0x0 0x10000>;
 	};
 
-	fpga: board-control at 200000000 {
+	fpga: board-control at 2,0 {
 		compatible = "fsl,ls1046aqds-fpga", "fsl,fpga-qixis";
 		reg = <0x2 0x0 0x0000100>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index 18d3c5b..5dc2782 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -122,14 +122,14 @@
 		  0x2 0x0 0x0 0x7fb00000 0x00000100>;
 	status = "okay";
 
-	nand at 0 {
+	nand at 0,0 {
 		compatible = "fsl,ifc-nand";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x0 0x0 0x10000>;
 	};
 
-	cpld: board-control at 200000000 {
+	cpld: board-control at 2,0 {
 		compatible = "fsl,ls1046ardb-cpld";
 		reg = <0x2 0x0 0x0000100>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
index 0b96d6d..3012805 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
@@ -116,19 +116,19 @@
 		  3 0 0x5 0x20000000 0x00010000>;
 	status = "okay";
 
-	nor at 0 {
+	nor at 0,0 {
 		compatible = "cfi-flash";
 		reg = <0x0 0x0 0x8000000>;
 		bank-width = <2>;
 		device-width = <1>;
 	};
 
-	nand at 200000000 {
+	nand at 2,0 {
 		compatible = "fsl,ifc-nand";
 		reg = <0x2 0x0 0x10000>;
 	};
 
-	fpga: board-control at 300000000 {
+	fpga: board-control at 3,0 {
 		compatible = "fsl,ls1088aqds-fpga", "fsl,fpga-qixis";
 		reg = <0x3 0x0 0x0000100>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index 3d57008e..4f17601 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -99,12 +99,12 @@
 		  2 0 0x5 0x20000000 0x00010000>;
 	status = "okay";
 
-	nand at 0 {
+	nand at 0,0 {
 		compatible = "fsl,ifc-nand";
 		reg = <0x0 0x0 0x10000>;
 	};
 
-	fpga: board-control at 200000000 {
+	fpga: board-control at 2,0 {
 		compatible = "fsl,ls1088ardb-fpga", "fsl,fpga-qixis";
 		reg = <0x2 0x0 0x0000100>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
index 5ac3412..1de6188 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
@@ -58,7 +58,7 @@
 		  0x2 0x0 0x5 0x30000000 0x00010000
 		  0x3 0x0 0x5 0x20000000 0x00010000>;
 
-	nor at 0 {
+	nor at 0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";
@@ -67,12 +67,12 @@
 		device-width = <1>;
 	};
 
-	nand at 200000000 {
+	nand at 2,0 {
 	     compatible = "fsl,ifc-nand";
 	     reg = <0x2 0x0 0x10000>;
 	};
 
-	cpld at 300000000 {
+	cpld at 3,0 {
 	     reg = <0x3 0x0 0x10000>;
 	     compatible = "fsl,ls2080aqds-fpga", "fsl,fpga-qixis";
 	};
-- 
2.7.4
