From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:15 +0100
Subject: [PATCH 21/70] ARM: dts: r8a7740: use GIC_* defines
In-Reply-To: <cover.1454595846.git.horms+renesas@verge.net.au>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
Message-ID: <e1e7b6fa83f0d8372392662ebdffdd79c71ba6a3.1454595846.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GIC_* defines for GIC interrupt cells in r8a7740 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 143 +++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 71 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 6ef954766eef..36bcb39cca03 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -11,6 +11,7 @@
 /include/ "skeleton.dtsi"
 
 #include <dt-bindings/clock/r8a7740-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -41,7 +42,7 @@
 	L2: cache-controller {
 		compatible = "arm,pl310-cache";
 		reg = <0xf0100000 0x1000>;
-		interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd_a3sm>;
 		arm,data-latency = <3 3 3>;
 		arm,tag-latency = <2 2 2>;
@@ -58,7 +59,7 @@
 
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
-		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	ptm {
@@ -69,7 +70,7 @@
 	cmt1: timer at e6138000 {
 		compatible = "renesas,cmt-48-r8a7740", "renesas,cmt-48";
 		reg = <0xe6138000 0x170>;
-		interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7740_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&pd_c5>;
@@ -89,14 +90,14 @@
 			<0xe6900020 1>,
 			<0xe6900040 1>,
 			<0xe6900060 1>;
-		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_INTCA>;
 		power-domains = <&pd_a4s>;
 	};
@@ -111,14 +112,14 @@
 			<0xe6900024 1>,
 			<0xe6900044 1>,
 			<0xe6900064 1>;
-		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_INTCA>;
 		power-domains = <&pd_a4s>;
 	};
@@ -133,14 +134,14 @@
 			<0xe6900028 1>,
 			<0xe6900048 1>,
 			<0xe6900068 1>;
-		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_INTCA>;
 		power-domains = <&pd_a4s>;
 	};
@@ -155,14 +156,14 @@
 			<0xe690002c 1>,
 			<0xe690004c 1>,
 			<0xe690006c 1>;
-		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH
-			      0 149 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_INTCA>;
 		power-domains = <&pd_a4s>;
 	};
@@ -171,7 +172,7 @@
 		compatible = "renesas,gether-r8a7740";
 		reg = <0xe9a00000 0x800>,
 		      <0xe9a01800 0x800>;
-		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7740_CLK_GETHER>;
 		power-domains = <&pd_a4s>;
 		phy-mode = "mii";
@@ -185,10 +186,10 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a7740", "renesas,rmobile-iic";
 		reg = <0xfff20000 0x425>;
-		interrupts = <0 201 IRQ_TYPE_LEVEL_HIGH
-			      0 202 IRQ_TYPE_LEVEL_HIGH
-			      0 203 IRQ_TYPE_LEVEL_HIGH
-			      0 204 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7740_CLK_IIC0>;
 		power-domains = <&pd_a4r>;
 		status = "disabled";
@@ -199,10 +200,10 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a7740", "renesas,rmobile-iic";
 		reg = <0xe6c20000 0x425>;
-		interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH
-			      0 71 IRQ_TYPE_LEVEL_HIGH
-			      0 72 IRQ_TYPE_LEVEL_HIGH
-			      0 73 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7740_CLK_IIC1>;
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
@@ -211,7 +212,7 @@
 	scifa0: serial at e6c40000 {
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6c40000 0x100>;
-		interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA0>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -221,7 +222,7 @@
 	scifa1: serial at e6c50000 {
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6c50000 0x100>;
-		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA1>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -231,7 +232,7 @@
 	scifa2: serial at e6c60000 {
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6c60000 0x100>;
-		interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA2>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -241,7 +242,7 @@
 	scifa3: serial at e6c70000 {
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6c70000 0x100>;
-		interrupts = <0 103 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA3>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -251,7 +252,7 @@
 	scifa4: serial at e6c80000 {
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6c80000 0x100>;
-		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA4>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -261,7 +262,7 @@
 	scifa5: serial at e6cb0000 {
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6cb0000 0x100>;
-		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA5>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -271,7 +272,7 @@
 	scifa6: serial at e6cc0000 {
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6cc0000 0x100>;
-		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA6>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -281,7 +282,7 @@
 	scifa7: serial at e6cd0000 {
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6cd0000 0x100>;
-		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA7>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -291,7 +292,7 @@
 	scifb: serial at e6c30000 {
 		compatible = "renesas,scifb-r8a7740", "renesas,scifb";
 		reg = <0xe6c30000 0x100>;
-		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFB>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -329,8 +330,8 @@
 	mmcif0: mmc at e6bd0000 {
 		compatible = "renesas,mmcif-r8a7740", "renesas,sh-mmcif";
 		reg = <0xe6bd0000 0x100>;
-		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH
-			      0 57 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7740_CLK_MMC>;
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
@@ -339,9 +340,9 @@
 	sdhi0: sd at e6850000 {
 		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xe6850000 0x100>;
-		interrupts = <0 117 IRQ_TYPE_LEVEL_HIGH
-			      0 118 IRQ_TYPE_LEVEL_HIGH
-			      0 119 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7740_CLK_SDHI0>;
 		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
@@ -352,9 +353,9 @@
 	sdhi1: sd at e6860000 {
 		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xe6860000 0x100>;
-		interrupts = <0 121 IRQ_TYPE_LEVEL_HIGH
-			      0 122 IRQ_TYPE_LEVEL_HIGH
-			      0 123 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7740_CLK_SDHI1>;
 		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
@@ -365,9 +366,9 @@
 	sdhi2: sd at e6870000 {
 		compatible = "renesas,sdhi-r8a7740";
 		reg = <0xe6870000 0x100>;
-		interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH
-			      0 126 IRQ_TYPE_LEVEL_HIGH
-			      0 127 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A7740_CLK_SDHI2>;
 		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
@@ -379,7 +380,7 @@
 		#sound-dai-cells = <1>;
 		compatible = "renesas,fsi2-r8a7740", "renesas,sh_fsi2";
 		reg = <0xfe1f0000 0x400>;
-		interrupts = <0 9 0x4>;
+		interrupts = <GIC_SPI 9 0x4>;
 		clocks = <&mstp3_clks R8A7740_CLK_FSI>;
 		power-domains = <&pd_a4mp>;
 		status = "disabled";
@@ -388,9 +389,9 @@
 	tmu0: timer at fff80000 {
 		compatible = "renesas,tmu-r8a7740", "renesas,tmu";
 		reg = <0xfff80000 0x2c>;
-		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 199 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 200 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7740_CLK_TMU0>;
 		clock-names = "fck";
 		power-domains = <&pd_a4r>;
@@ -403,9 +404,9 @@
 	tmu1: timer at fff90000 {
 		compatible = "renesas,tmu-r8a7740", "renesas,tmu";
 		reg = <0xfff90000 0x2c>;
-		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 171 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 172 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7740_CLK_TMU1>;
 		clock-names = "fck";
 		power-domains = <&pd_a4r>;
-- 
2.7.0.rc3.207.g0ac5344
