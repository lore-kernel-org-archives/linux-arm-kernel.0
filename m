From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:53:05 +0100
Subject: [PATCH 46/52] ARM: dts: r7s72100: sort subnodes of root node
In-Reply-To: <cover.1521208546.git.horms+renesas@verge.net.au>
References: <cover.1521208546.git.horms+renesas@verge.net.au>
Message-ID: <8234641d84ca17e0f6f8cfbb4f34fa56d73a07ab.1521208546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort the subnodes of the soc node to improve maintainability.
The sort has been done alphabetically with the node name as the key.

This patch should not introduce any functional change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r7s72100.dtsi | 78 +++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index d69d4810e597..ecf9516bcda8 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -30,43 +30,45 @@
 		spi4 = &spi4;
 	};
 
-	/* External clocks */
-	extal_clk: extal {
+	/* Fixed factor clocks */
+	b_clk: b {
 		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		/* If clk present, value must be set by board */
-		clock-frequency = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&cpg_clocks R7S72100_CLK_PLL>;
+		clock-mult = <1>;
+		clock-div = <3>;
 	};
 
-	usb_x1_clk: usb_x1 {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		/* If clk present, value must be set by board */
-		clock-frequency = <0>;
-	};
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-	rtc_x1_clk: rtc_x1 {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		/* If clk present, value must be set by board to 32678 */
-		clock-frequency = <0>;
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			clock-frequency = <400000000>;
+			clocks = <&cpg_clocks R7S72100_CLK_I>;
+			next-level-cache = <&L2>;
+		};
 	};
 
-	rtc_x3_clk: rtc_x3 {
+	/* External clocks */
+	extal_clk: extal {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
-		/* If clk present, value must be set by board to 4000000 */
+		/* If clk present, value must be set by board */
 		clock-frequency = <0>;
 	};
 
-	/* Fixed factor clocks */
-	b_clk: b {
+	p0_clk: p0 {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
 		clocks = <&cpg_clocks R7S72100_CLK_PLL>;
 		clock-mult = <1>;
-		clock-div = <3>;
+		clock-div = <12>;
 	};
+
 	p1_clk: p1 {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
@@ -74,26 +76,19 @@
 		clock-mult = <1>;
 		clock-div = <6>;
 	};
-	p0_clk: p0 {
+
+	rtc_x1_clk: rtc_x1 {
 		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&cpg_clocks R7S72100_CLK_PLL>;
-		clock-mult = <1>;
-		clock-div = <12>;
+		compatible = "fixed-clock";
+		/* If clk present, value must be set by board to 32678 */
+		clock-frequency = <0>;
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu at 0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			reg = <0>;
-			clock-frequency = <400000000>;
-			clocks = <&cpg_clocks R7S72100_CLK_I>;
-			next-level-cache = <&L2>;
-		};
+	rtc_x3_clk: rtc_x3 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		/* If clk present, value must be set by board to 4000000 */
+		clock-frequency = <0>;
 	};
 
 	soc {
@@ -689,4 +684,11 @@
 			status = "disabled";
 		};
 	};
+
+	usb_x1_clk: usb_x1 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		/* If clk present, value must be set by board */
+		clock-frequency = <0>;
+	};
 };
-- 
2.11.0
