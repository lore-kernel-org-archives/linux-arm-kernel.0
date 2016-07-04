From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 05 Jul 2016 00:22:38 +0300
Subject: [PATCH 1/2] ARM: dts: r8a7792: add EtherAVB clocks
In-Reply-To: <3308853.O8HBuWdbK9@wasted.cogentembedded.com>
References: <3308853.O8HBuWdbK9@wasted.cogentembedded.com>
Message-ID: <1541732.nlEXTHQe9F@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the EtherAVB clock and its parent, HP clock to the R8A7792 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -464,6 +464,13 @@
 			clock-div = <6>;
 			clock-mult = <1>;
 		};
+		hp_clk: hp {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <12>;
+			clock-mult = <1>;
+		};
 		p_clk: p {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
@@ -531,6 +538,15 @@
 			clock-output-names = "hscif1", "hscif0", "scif3",
 					     "scif2", "scif1", "scif0";
 		};
+		mstp8_clks: mstp8_clks at e6150990 {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
+			clocks = <&hp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7792_CLK_ETHERAVB>;
+			clock-output-names = "etheravb";
+		};
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7792-mstp-clocks",
 				     "renesas,cpg-mstp-clocks";
