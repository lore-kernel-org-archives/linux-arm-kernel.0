From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Jan 2016 10:29:44 +0900
Subject: [PATCH] ARM: dts: sh73a0: use GIC_* defines
Message-ID: <1453944584-24714-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GIC_* defines for GIC interrupt cells in sh73a0 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on renesas-devel-20160127-v4.5-rc1
---
 arch/arm/boot/dts/sh73a0.dtsi | 168 +++++++++++++++++++++---------------------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 3a6056f9f0d2..453280c41d27 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -58,7 +58,7 @@
 	L2: cache-controller {
 		compatible = "arm,pl310-cache";
 		reg = <0xf0100000 0x1000>;
-		interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd_a3sm>;
 		arm,data-latency = <3 3 3>;
 		arm,tag-latency = <2 2 2>;
@@ -70,8 +70,8 @@
 	sbsc2: memory-controller at fb400000 {
 		compatible = "renesas,sbsc-sh73a0";
 		reg = <0xfb400000 0x400>;
-		interrupts = <0 37 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 38 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "sec", "temp";
 		power-domains = <&pd_a4bc1>;
 	};
@@ -79,22 +79,22 @@
 	sbsc1: memory-controller at fe400000 {
 		compatible = "renesas,sbsc-sh73a0";
 		reg = <0xfe400000 0x400>;
-		interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 36 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "sec", "temp";
 		power-domains = <&pd_a4bc0>;
 	};
 
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
-		interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 56 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	cmt1: timer at e6138000 {
 		compatible = "renesas,cmt-48-sh73a0", "renesas,cmt-48";
 		reg = <0xe6138000 0x200>;
-		interrupts = <0 65 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&pd_c5>;
@@ -113,14 +113,14 @@
 			<0xe6900020 1>,
 			<0xe6900040 1>,
 			<0xe6900060 1>;
-		interrupts = <0 1 IRQ_TYPE_LEVEL_HIGH
-			      0 2 IRQ_TYPE_LEVEL_HIGH
-			      0 3 IRQ_TYPE_LEVEL_HIGH
-			      0 4 IRQ_TYPE_LEVEL_HIGH
-			      0 5 IRQ_TYPE_LEVEL_HIGH
-			      0 6 IRQ_TYPE_LEVEL_HIGH
-			      0 7 IRQ_TYPE_LEVEL_HIGH
-			      0 8 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
 		power-domains = <&pd_a4s>;
 		control-parent;
@@ -135,14 +135,14 @@
 			<0xe6900024 1>,
 			<0xe6900044 1>,
 			<0xe6900064 1>;
-		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH
-			      0 10 IRQ_TYPE_LEVEL_HIGH
-			      0 11 IRQ_TYPE_LEVEL_HIGH
-			      0 12 IRQ_TYPE_LEVEL_HIGH
-			      0 13 IRQ_TYPE_LEVEL_HIGH
-			      0 14 IRQ_TYPE_LEVEL_HIGH
-			      0 15 IRQ_TYPE_LEVEL_HIGH
-			      0 16 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
 		power-domains = <&pd_a4s>;
 		control-parent;
@@ -157,14 +157,14 @@
 			<0xe6900028 1>,
 			<0xe6900048 1>,
 			<0xe6900068 1>;
-		interrupts = <0 17 IRQ_TYPE_LEVEL_HIGH
-			      0 18 IRQ_TYPE_LEVEL_HIGH
-			      0 19 IRQ_TYPE_LEVEL_HIGH
-			      0 20 IRQ_TYPE_LEVEL_HIGH
-			      0 21 IRQ_TYPE_LEVEL_HIGH
-			      0 22 IRQ_TYPE_LEVEL_HIGH
-			      0 23 IRQ_TYPE_LEVEL_HIGH
-			      0 24 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
 		power-domains = <&pd_a4s>;
 		control-parent;
@@ -179,14 +179,14 @@
 			<0xe690002c 1>,
 			<0xe690004c 1>,
 			<0xe690006c 1>;
-		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH
-			      0 26 IRQ_TYPE_LEVEL_HIGH
-			      0 27 IRQ_TYPE_LEVEL_HIGH
-			      0 28 IRQ_TYPE_LEVEL_HIGH
-			      0 29 IRQ_TYPE_LEVEL_HIGH
-			      0 30 IRQ_TYPE_LEVEL_HIGH
-			      0 31 IRQ_TYPE_LEVEL_HIGH
-			      0 32 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
 		power-domains = <&pd_a4s>;
 		control-parent;
@@ -197,10 +197,10 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-sh73a0", "renesas,rmobile-iic";
 		reg = <0xe6820000 0x425>;
-		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH
-			      0 168 IRQ_TYPE_LEVEL_HIGH
-			      0 169 IRQ_TYPE_LEVEL_HIGH
-			      0 170 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks SH73A0_CLK_IIC0>;
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
@@ -211,10 +211,10 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-sh73a0", "renesas,rmobile-iic";
 		reg = <0xe6822000 0x425>;
-		interrupts = <0 51 IRQ_TYPE_LEVEL_HIGH
-			      0 52 IRQ_TYPE_LEVEL_HIGH
-			      0 53 IRQ_TYPE_LEVEL_HIGH
-			      0 54 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_IIC1>;
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
@@ -225,10 +225,10 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-sh73a0", "renesas,rmobile-iic";
 		reg = <0xe6824000 0x425>;
-		interrupts = <0 171 IRQ_TYPE_LEVEL_HIGH
-			      0 172 IRQ_TYPE_LEVEL_HIGH
-			      0 173 IRQ_TYPE_LEVEL_HIGH
-			      0 174 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks SH73A0_CLK_IIC2>;
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
@@ -239,10 +239,10 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-sh73a0", "renesas,rmobile-iic";
 		reg = <0xe6826000 0x425>;
-		interrupts = <0 183 IRQ_TYPE_LEVEL_HIGH
-			      0 184 IRQ_TYPE_LEVEL_HIGH
-			      0 185 IRQ_TYPE_LEVEL_HIGH
-			      0 186 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks SH73A0_CLK_IIC3>;
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
@@ -253,10 +253,10 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-sh73a0", "renesas,rmobile-iic";
 		reg = <0xe6828000 0x425>;
-		interrupts = <0 187 IRQ_TYPE_LEVEL_HIGH
-			      0 188 IRQ_TYPE_LEVEL_HIGH
-			      0 189 IRQ_TYPE_LEVEL_HIGH
-			      0 190 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks SH73A0_CLK_IIC4>;
 		power-domains = <&pd_c5>;
 		status = "disabled";
@@ -265,8 +265,8 @@
 	mmcif: mmc at e6bd0000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0xe6bd0000 0x100>;
-		interrupts = <0 140 IRQ_TYPE_LEVEL_HIGH
-			      0 141 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_MMCIF0>;
 		power-domains = <&pd_a3sp>;
 		reg-io-width = <4>;
@@ -276,7 +276,7 @@
 	msiof0: spi at e6e20000 {
 		compatible = "renesas,msiof-sh73a0", "renesas,sh-mobile-msiof";
 		reg = <0xe6e20000 0x0064>;
-		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks SH73A0_CLK_MSIOF0>;
 		power-domains = <&pd_a3sp>;
 		#address-cells = <1>;
@@ -287,7 +287,7 @@
 	msiof1: spi at e6e10000 {
 		compatible = "renesas,msiof-sh73a0", "renesas,sh-mobile-msiof";
 		reg = <0xe6e10000 0x0064>;
-		interrupts = <0 77 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_MSIOF1>;
 		power-domains = <&pd_a3sp>;
 		#address-cells = <1>;
@@ -298,7 +298,7 @@
 	msiof2: spi at e6e00000 {
 		compatible = "renesas,msiof-sh73a0", "renesas,sh-mobile-msiof";
 		reg = <0xe6e00000 0x0064>;
-		interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_MSIOF2>;
 		power-domains = <&pd_a3sp>;
 		#address-cells = <1>;
@@ -309,7 +309,7 @@
 	msiof3: spi at e6c90000 {
 		compatible = "renesas,msiof-sh73a0", "renesas,sh-mobile-msiof";
 		reg = <0xe6c90000 0x0064>;
-		interrupts = <0 59 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_MSIOF3>;
 		power-domains = <&pd_a3sp>;
 		#address-cells = <1>;
@@ -320,9 +320,9 @@
 	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-sh73a0";
 		reg = <0xee100000 0x100>;
-		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH
-			      0 84 IRQ_TYPE_LEVEL_HIGH
-			      0 85 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_SDHI0>;
 		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
@@ -333,8 +333,8 @@
 	sdhi1: sd at ee120000 {
 		compatible = "renesas,sdhi-sh73a0";
 		reg = <0xee120000 0x100>;
-		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH
-			      0 89 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_SDHI1>;
 		power-domains = <&pd_a3sp>;
 		toshiba,mmc-wrprotect-disable;
@@ -345,8 +345,8 @@
 	sdhi2: sd at ee140000 {
 		compatible = "renesas,sdhi-sh73a0";
 		reg = <0xee140000 0x100>;
-		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH
-			      0 105 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_SDHI2>;
 		power-domains = <&pd_a3sp>;
 		toshiba,mmc-wrprotect-disable;
@@ -357,7 +357,7 @@
 	scifa0: serial at e6c40000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c40000 0x100>;
-		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA0>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -367,7 +367,7 @@
 	scifa1: serial at e6c50000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c50000 0x100>;
-		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA1>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -377,7 +377,7 @@
 	scifa2: serial at e6c60000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c60000 0x100>;
-		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA2>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -387,7 +387,7 @@
 	scifa3: serial at e6c70000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c70000 0x100>;
-		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA3>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -397,7 +397,7 @@
 	scifa4: serial at e6c80000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6c80000 0x100>;
-		interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA4>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -407,7 +407,7 @@
 	scifa5: serial at e6cb0000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6cb0000 0x100>;
-		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA5>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -417,7 +417,7 @@
 	scifa6: serial at e6cc0000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6cc0000 0x100>;
-		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_SCIFA6>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -427,7 +427,7 @@
 	scifa7: serial at e6cd0000 {
 		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
 		reg = <0xe6cd0000 0x100>;
-		interrupts = <0 143 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFA7>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -437,7 +437,7 @@
 	scifb: serial at e6c30000 {
 		compatible = "renesas,scifb-sh73a0", "renesas,scifb";
 		reg = <0xe6c30000 0x100>;
-		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks SH73A0_CLK_SCIFB>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -579,7 +579,7 @@
 		#sound-dai-cells = <1>;
 		compatible = "renesas,fsi2-sh73a0", "renesas,sh_fsi2";
 		reg = <0xec230000 0x400>;
-		interrupts = <0 146 0x4>;
+		interrupts = <GIC_SPI 146 0x4>;
 		power-domains = <&pd_a4mp>;
 		status = "disabled";
 	};
@@ -591,7 +591,7 @@
 		#size-cells = <1>;
 		ranges = <0 0 0x20000000>;
 		reg = <0xfec10000 0x400>;
-		interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&zb_clk>;
 		power-domains = <&pd_a4s>;
 	};
-- 
2.1.4
