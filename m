From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  6 Jan 2014 13:58:09 +0800
Subject: [PATCH v2 5/8] arm: dts: sun5i: rename clock node names to clk@N
In-Reply-To: <1388987892-23733-1-git-send-email-wens@csie.org>
References: <1388987892-23733-1-git-send-email-wens@csie.org>
Message-ID: <1388987892-23733-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree naming conventions state that node names should match
node function. Change fully functioning clock nodes to match.

Also add the output name for pll5 to use as the clock name.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 26 +++++++++++++++-----------
 arch/arm/boot/dts/sun5i-a13.dtsi  | 26 +++++++++++++++-----------
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 78360b3..b67553b 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -47,42 +47,46 @@
 			clock-frequency = <0>;
 		};
 
-		osc24M: osc24M at 01c20050 {
+		osc24M: clk at 01c20050 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-osc-clk";
 			reg = <0x01c20050 0x4>;
 			clock-frequency = <24000000>;
+			clock-output-names = "osc24M";
 		};
 
-		osc32k: osc32k {
+		osc32k: clk at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
+			clock-output-names = "osc32k";
 		};
 
-		pll1: pll1 at 01c20000 {
+		pll1: clk at 01c20000 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-pll1-clk";
 			reg = <0x01c20000 0x4>;
 			clocks = <&osc24M>;
+			clock-output-names = "pll1";
 		};
 
-		pll4: pll4 at 01c20018 {
+		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-pll1-clk";
 			reg = <0x01c20018 0x4>;
 			clocks = <&osc24M>;
+			clock-output-names = "pll4";
 		};
 
-		pll5: pll5 at 01c20020 {
+		pll5: clk at 01c20020 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-pll5-clk";
 			reg = <0x01c20020 0x4>;
 			clocks = <&osc24M>;
-			clock-output-names = "pll5_ddr", "pll5_other";
+			clock-output-names = "pll5_ddr", "pll5_other", "pll5";
 		};
 
-		pll6: pll6 at 01c20028 {
+		pll6: clk at 01c20028 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-pll6-clk";
 			reg = <0x01c20028 0x4>;
@@ -105,7 +109,7 @@
 			clocks = <&cpu>;
 		};
 
-		axi_gates: axi_gates at 01c2005c {
+		axi_gates: clk at 01c2005c {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-axi-gates-clk";
 			reg = <0x01c2005c 0x4>;
@@ -120,7 +124,7 @@
 			clocks = <&axi>;
 		};
 
-		ahb_gates: ahb_gates at 01c20060 {
+		ahb_gates: clk at 01c20060 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun5i-a10s-ahb-gates-clk";
 			reg = <0x01c20060 0x8>;
@@ -141,7 +145,7 @@
 			clocks = <&ahb>;
 		};
 
-		apb0_gates: apb0_gates at 01c20068 {
+		apb0_gates: clk at 01c20068 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun5i-a10s-apb0-gates-clk";
 			reg = <0x01c20068 0x4>;
@@ -164,7 +168,7 @@
 			clocks = <&apb1_mux>;
 		};
 
-		apb1_gates: apb1_gates at 01c2006c {
+		apb1_gates: clk at 01c2006c {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun5i-a10s-apb1-gates-clk";
 			reg = <0x01c2006c 0x4>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 2f37ca5..76d6f7a 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -47,42 +47,46 @@
 			clock-frequency = <0>;
 		};
 
-		osc24M: osc24M at 01c20050 {
+		osc24M: clk at 01c20050 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-osc-clk";
 			reg = <0x01c20050 0x4>;
 			clock-frequency = <24000000>;
+			clock-output-names = "osc24M";
 		};
 
-		osc32k: osc32k {
+		osc32k: clk at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
+			clock-output-names = "osc32k";
 		};
 
-		pll1: pll1 at 01c20000 {
+		pll1: clk at 01c20000 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-pll1-clk";
 			reg = <0x01c20000 0x4>;
 			clocks = <&osc24M>;
+			clock-output-names = "pll1";
 		};
 
-		pll4: pll4 at 01c20018 {
+		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-pll1-clk";
 			reg = <0x01c20018 0x4>;
 			clocks = <&osc24M>;
+			clock-output-names = "pll4";
 		};
 
-		pll5: pll5 at 01c20020 {
+		pll5: clk at 01c20020 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-pll5-clk";
 			reg = <0x01c20020 0x4>;
 			clocks = <&osc24M>;
-			clock-output-names = "pll5_ddr", "pll5_other";
+			clock-output-names = "pll5_ddr", "pll5_other", "pll5";
 		};
 
-		pll6: pll6 at 01c20028 {
+		pll6: clk at 01c20028 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-pll6-clk";
 			reg = <0x01c20028 0x4>;
@@ -105,7 +109,7 @@
 			clocks = <&cpu>;
 		};
 
-		axi_gates: axi_gates at 01c2005c {
+		axi_gates: clk at 01c2005c {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-axi-gates-clk";
 			reg = <0x01c2005c 0x4>;
@@ -120,7 +124,7 @@
 			clocks = <&axi>;
 		};
 
-		ahb_gates: ahb_gates at 01c20060 {
+		ahb_gates: clk at 01c20060 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun5i-a13-ahb-gates-clk";
 			reg = <0x01c20060 0x8>;
@@ -140,7 +144,7 @@
 			clocks = <&ahb>;
 		};
 
-		apb0_gates: apb0_gates at 01c20068 {
+		apb0_gates: clk at 01c20068 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun5i-a13-apb0-gates-clk";
 			reg = <0x01c20068 0x4>;
@@ -162,7 +166,7 @@
 			clocks = <&apb1_mux>;
 		};
 
-		apb1_gates: apb1_gates at 01c2006c {
+		apb1_gates: clk at 01c2006c {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun5i-a13-apb1-gates-clk";
 			reg = <0x01c2006c 0x4>;
-- 
1.8.5.2
