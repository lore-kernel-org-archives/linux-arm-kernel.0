From: plaes@plaes.org (Priit Laes)
Date: Tue,  3 May 2016 20:14:18 +0300
Subject: [PATCH 1/2] ARM: sun4i: dt: Add pll3 and pll7 clocks
In-Reply-To: <1462295659-6945-1-git-send-email-plaes@plaes.org>
References: <1462295659-6945-1-git-send-email-plaes@plaes.org>
Message-ID: <1462295659-6945-2-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pll3 and pll7 clocks that are needed to drive display clocks.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 268a150..c893744 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -184,6 +184,15 @@
 			clock-output-names = "osc24M";
 		};
 
+		osc3M: osc3M_clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+			clocks = <&osc24M>;
+			clock-output-names = "osc3M";
+		};
+
 		osc32k: clk at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -208,6 +217,24 @@
 					     "pll2-4x", "pll2-8x";
 		};
 
+		pll3: clk at 01c20010 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-pll3-clk";
+			reg = <0x01c20010 0x4>;
+			clocks = <&osc3M>;
+			clock-output-names = "pll3";
+		};
+
+		pll3x2: pll3x2_clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <2>;
+			clocks = <&pll3>;
+			clock-output-names = "pll3-x2";
+		};
+
+
 		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-pll1-clk";
@@ -232,6 +259,23 @@
 			clock-output-names = "pll6_sata", "pll6_other", "pll6";
 		};
 
+		pll7: clk at 01c20030 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-pll3-clk";
+			reg = <0x01c20030 0x4>;
+			clocks = <&osc3M>;
+			clock-output-names = "pll7";
+		};
+
+		pll7x2: pll7x2_clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <2>;
+			clocks = <&pll7>;
+			clock-output-names = "pll7-2x";
+		};
+
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
-- 
2.8.1
