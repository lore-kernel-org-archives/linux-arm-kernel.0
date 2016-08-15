From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Aug 2016 10:55:25 +0200
Subject: [PATCH 06/26] ARM: dts: r8a7792: add EtherAVB clocks
In-Reply-To: <cover.1471251169.git.horms+renesas@verge.net.au>
References: <cover.1471251169.git.horms+renesas@verge.net.au>
Message-ID: <08cafff67e8881e1622068924aaab3c3aa052b0b.1471251169.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the EtherAVB clock and its parent, HP clock to the R8A7792 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index d5ab9474297e..f97b034da35f 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -471,6 +471,13 @@
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
@@ -538,6 +545,15 @@
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
-- 
2.7.0.rc3.207.g0ac5344
