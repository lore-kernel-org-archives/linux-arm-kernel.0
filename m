From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:07 +0900
Subject: [PATCH 7/7] ARM: shmobile: sh73a0 dtsi: Move interrupt-parent to the
 top
In-Reply-To: <cover.1408928822.git.horms+renesas@verge.net.au>
References: <cover.1408928822.git.horms+renesas@verge.net.au>
Message-ID: <f170b97c9ad0b8ba3e99f02cbadc7676383fee09.1408928822.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add an "interrupt-parent = <&gic>;" at the top, which is inherited by
all child nodes, so the "interrupt-parent" properties can be removed
from the individual child nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 910b790..c959355 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -14,6 +14,7 @@
 
 / {
 	compatible = "renesas,sh73a0";
+	interrupt-parent = <&gic>;
 
 	cpus {
 		#address-cells = <1>;
@@ -54,7 +55,6 @@
 			<0xe6900020 1>,
 			<0xe6900040 1>,
 			<0xe6900060 1>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 1 IRQ_TYPE_LEVEL_HIGH
 			      0 2 IRQ_TYPE_LEVEL_HIGH
 			      0 3 IRQ_TYPE_LEVEL_HIGH
@@ -74,7 +74,6 @@
 			<0xe6900024 1>,
 			<0xe6900044 1>,
 			<0xe6900064 1>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH
 			      0 10 IRQ_TYPE_LEVEL_HIGH
 			      0 11 IRQ_TYPE_LEVEL_HIGH
@@ -95,7 +94,6 @@
 			<0xe6900028 1>,
 			<0xe6900048 1>,
 			<0xe6900068 1>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 17 IRQ_TYPE_LEVEL_HIGH
 			      0 18 IRQ_TYPE_LEVEL_HIGH
 			      0 19 IRQ_TYPE_LEVEL_HIGH
@@ -115,7 +113,6 @@
 			<0xe690002c 1>,
 			<0xe690004c 1>,
 			<0xe690006c 1>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH
 			      0 26 IRQ_TYPE_LEVEL_HIGH
 			      0 27 IRQ_TYPE_LEVEL_HIGH
@@ -131,7 +128,6 @@
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
 		reg = <0xe6820000 0x425>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH
 			      0 168 IRQ_TYPE_LEVEL_HIGH
 			      0 169 IRQ_TYPE_LEVEL_HIGH
@@ -144,7 +140,6 @@
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
 		reg = <0xe6822000 0x425>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 51 IRQ_TYPE_LEVEL_HIGH
 			      0 52 IRQ_TYPE_LEVEL_HIGH
 			      0 53 IRQ_TYPE_LEVEL_HIGH
@@ -157,7 +152,6 @@
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
 		reg = <0xe6824000 0x425>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 171 IRQ_TYPE_LEVEL_HIGH
 			      0 172 IRQ_TYPE_LEVEL_HIGH
 			      0 173 IRQ_TYPE_LEVEL_HIGH
@@ -170,7 +164,6 @@
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
 		reg = <0xe6826000 0x425>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 183 IRQ_TYPE_LEVEL_HIGH
 			      0 184 IRQ_TYPE_LEVEL_HIGH
 			      0 185 IRQ_TYPE_LEVEL_HIGH
@@ -183,7 +176,6 @@
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
 		reg = <0xe6828000 0x425>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 187 IRQ_TYPE_LEVEL_HIGH
 			      0 188 IRQ_TYPE_LEVEL_HIGH
 			      0 189 IRQ_TYPE_LEVEL_HIGH
@@ -194,7 +186,6 @@
 	mmcif: mmc@e6bd0000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0xe6bd0000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 140 IRQ_TYPE_LEVEL_HIGH
 			      0 141 IRQ_TYPE_LEVEL_HIGH>;
 		reg-io-width = <4>;
@@ -204,7 +195,6 @@
 	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-sh73a0";
 		reg = <0xee100000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH
 			      0 84 IRQ_TYPE_LEVEL_HIGH
 			      0 85 IRQ_TYPE_LEVEL_HIGH>;
@@ -216,7 +206,6 @@
 	sdhi1: sd at ee120000 {
 		compatible = "renesas,sdhi-sh73a0";
 		reg = <0xee120000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH
 			      0 89 IRQ_TYPE_LEVEL_HIGH>;
 		toshiba,mmc-wrprotect-disable;
@@ -227,7 +216,6 @@
 	sdhi2: sd at ee140000 {
 		compatible = "renesas,sdhi-sh73a0";
 		reg = <0xee140000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH
 			      0 105 IRQ_TYPE_LEVEL_HIGH>;
 		toshiba,mmc-wrprotect-disable;
@@ -238,7 +226,6 @@
 	scifa0: serial at e6c40000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c40000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
@@ -246,7 +233,6 @@
 	scifa1: serial at e6c50000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c50000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
@@ -254,7 +240,6 @@
 	scifa2: serial at e6c60000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c60000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
@@ -262,7 +247,6 @@
 	scifa3: serial at e6c70000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c70000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
@@ -270,7 +254,6 @@
 	scifa4: serial at e6c80000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c80000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
@@ -278,7 +261,6 @@
 	scifa5: serial at e6cb0000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6cb0000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
@@ -286,7 +268,6 @@
 	scifa6: serial at e6cc0000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6cc0000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
@@ -294,7 +275,6 @@
 	scifa7: serial at e6cd0000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6cd0000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 143 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
@@ -302,7 +282,6 @@
 	scifb8: serial at e6c30000 {
 		compatible = "renesas,scifb-sh73a0", "renesas,scifb";
 		reg = <0xe6c30000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
@@ -328,7 +307,6 @@
 		#sound-dai-cells = <1>;
 		compatible = "renesas,sh_fsi2";
 		reg = <0xec230000 0x400>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 146 0x4>;
 		status = "disabled";
 	};
-- 
2.0.1
