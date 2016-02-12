From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 12 Feb 2016 20:05:10 +0100
Subject: [PATCH 20/68] ARM: dts: r8a73a4: use GIC_* defines
In-Reply-To: <cover.1455303422.git.horms+renesas@verge.net.au>
References: <cover.1455303422.git.horms+renesas@verge.net.au>
Message-ID: <4d5746a3ec3a705028aeb81b34fbca70e523668a.1455303422.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GIC_* defines for GIC interrupt cells in r8a73a4 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 212 ++++++++++++++++++++---------------------
 1 file changed, 106 insertions(+), 106 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index cb4f7b2798fe..64f3efcd7ba5 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -39,10 +39,10 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <1 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <1 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <1 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	dbsc1: memory-controller at e6790000 {
@@ -69,27 +69,27 @@
 		dma0: dma-controller at e6700020 {
 			compatible = "renesas,shdma-r8a73a4";
 			reg = <0 0xe6700020 0 0x89e0>;
-			interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
-					0 200 IRQ_TYPE_LEVEL_HIGH
-					0 201 IRQ_TYPE_LEVEL_HIGH
-					0 202 IRQ_TYPE_LEVEL_HIGH
-					0 203 IRQ_TYPE_LEVEL_HIGH
-					0 204 IRQ_TYPE_LEVEL_HIGH
-					0 205 IRQ_TYPE_LEVEL_HIGH
-					0 206 IRQ_TYPE_LEVEL_HIGH
-					0 207 IRQ_TYPE_LEVEL_HIGH
-					0 208 IRQ_TYPE_LEVEL_HIGH
-					0 209 IRQ_TYPE_LEVEL_HIGH
-					0 210 IRQ_TYPE_LEVEL_HIGH
-					0 211 IRQ_TYPE_LEVEL_HIGH
-					0 212 IRQ_TYPE_LEVEL_HIGH
-					0 213 IRQ_TYPE_LEVEL_HIGH
-					0 214 IRQ_TYPE_LEVEL_HIGH
-					0 215 IRQ_TYPE_LEVEL_HIGH
-					0 216 IRQ_TYPE_LEVEL_HIGH
-					0 217 IRQ_TYPE_LEVEL_HIGH
-					0 218 IRQ_TYPE_LEVEL_HIGH
-					0 219 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "error",
 					"ch0", "ch1", "ch2", "ch3",
 					"ch4", "ch5", "ch6", "ch7",
@@ -106,7 +106,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe60b0000 0 0x428>;
-		interrupts = <0 179 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A73A4_CLK_IIC5>;
 		power-domains = <&pd_a3sp>;
 
@@ -116,7 +116,7 @@
 	cmt1: timer at e6130000 {
 		compatible = "renesas,cmt-48-r8a73a4", "renesas,cmt-48-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
-		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&pd_c5>;
@@ -131,38 +131,38 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0 0xe61c0000 0 0x200>;
-		interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 1 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 2 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 3 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 4 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 5 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 6 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 7 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 8 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 9 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 10 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 11 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 12 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 13 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 14 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 15 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 16 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 17 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 18 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 19 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 20 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 21 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 22 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 23 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 24 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 25 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 26 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 27 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 28 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 29 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 30 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A73A4_CLK_IRQC>;
 		power-domains = <&pd_c4>;
 	};
@@ -172,32 +172,32 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0 0xe61c0200 0 0x200>;
-		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 34 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 35 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 36 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 37 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 38 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 39 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 40 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 42 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 43 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 44 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 45 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 46 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 47 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 48 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 49 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 50 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 51 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 52 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 53 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 54 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 55 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 56 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 57 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A73A4_CLK_IRQC>;
 		power-domains = <&pd_c4>;
 	};
@@ -237,7 +237,7 @@
 		compatible = "renesas,thermal-r8a73a4", "renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>,
 			 <0 0xe61f0200 0 0x38>, <0 0xe61f0300 0 0x38>;
-		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A73A4_CLK_THERMAL>;
 		power-domains = <&pd_c5>;
 	};
@@ -247,7 +247,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6500000 0 0x428>;
-		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_IIC0>;
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
@@ -258,7 +258,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6510000 0 0x428>;
-		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_IIC1>;
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
@@ -269,7 +269,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6520000 0 0x428>;
-		interrupts = <0 176 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_IIC2>;
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
@@ -280,7 +280,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6530000 0 0x428>;
-		interrupts = <0 177 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A73A4_CLK_IIC3>;
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
@@ -291,7 +291,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6540000 0 0x428>;
-		interrupts = <0 178 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A73A4_CLK_IIC4>;
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
@@ -302,7 +302,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6550000 0 0x428>;
-		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_IIC6>;
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
@@ -313,7 +313,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6560000 0 0x428>;
-		interrupts = <0 185 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_IIC7>;
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
@@ -324,7 +324,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6570000 0 0x428>;
-		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A73A4_CLK_IIC8>;
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
@@ -333,7 +333,7 @@
 	scifb0: serial at e6c20000 {
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6c20000 0 0x100>;
-		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB0>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -343,7 +343,7 @@
 	scifb1: serial at e6c30000 {
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6c30000 0 0x100>;
-		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB1>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -353,7 +353,7 @@
 	scifa0: serial at e6c40000 {
 		compatible = "renesas,scifa-r8a73a4", "renesas,scifa";
 		reg = <0 0xe6c40000 0 0x100>;
-		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFA0>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -363,7 +363,7 @@
 	scifa1: serial at e6c50000 {
 		compatible = "renesas,scifa-r8a73a4", "renesas,scifa";
 		reg = <0 0xe6c50000 0 0x100>;
-		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFA1>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -373,7 +373,7 @@
 	scifb2: serial at e6ce0000 {
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 0x100>;
-		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB2>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_a3sp>;
@@ -383,7 +383,7 @@
 	scifb3: serial at e6cf0000 {
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6cf0000 0 0x100>;
-		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB3>;
 		clock-names = "sci_ick";
 		power-domains = <&pd_c4>;
@@ -393,7 +393,7 @@
 	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee100000 0 0x100>;
-		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_SDHI0>;
 		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
@@ -403,7 +403,7 @@
 	sdhi1: sd at ee120000 {
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee120000 0 0x100>;
-		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_SDHI1>;
 		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
@@ -413,7 +413,7 @@
 	sdhi2: sd at ee140000 {
 		compatible = "renesas,sdhi-r8a73a4";
 		reg = <0 0xee140000 0 0x100>;
-		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_SDHI2>;
 		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
@@ -423,7 +423,7 @@
 	mmcif0: mmc at ee200000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
-		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_MMCIF0>;
 		power-domains = <&pd_a3sp>;
 		reg-io-width = <4>;
@@ -433,7 +433,7 @@
 	mmcif1: mmc at ee220000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee220000 0 0x80>;
-		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_MMCIF1>;
 		power-domains = <&pd_a3sp>;
 		reg-io-width = <4>;
@@ -449,7 +449,7 @@
 			<0 0xf1002000 0 0x1000>,
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
-		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	bsc: bus at fec10000 {
-- 
2.7.0.rc3.207.g0ac5344
