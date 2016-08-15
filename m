From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Aug 2016 10:55:44 +0200
Subject: [PATCH 25/26] ARM: dts: r8a7792: add DU clocks
In-Reply-To: <cover.1471251169.git.horms+renesas@verge.net.au>
References: <cover.1471251169.git.horms+renesas@verge.net.au>
Message-ID: <3b0211af06298682d5faaa4c4cedf666fb1281c3.1471251169.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe the DU0/1 clocks and their parent, ZX clock in the R8A7792 device
tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index eaa0c48c6184..7e0c57ff9892 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -660,6 +660,13 @@
 			clock-div = <2>;
 			clock-mult = <1>;
 		};
+		zx_clk: zx {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <3>;
+			clock-mult = <1>;
+		};
 		zs_clk: zs {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
@@ -761,15 +768,17 @@
 				     "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
 			clocks = <&zs_clk>, <&zs_clk>, <&p_clk>, <&p_clk>,
-				 <&p_clk>, <&p_clk>;
+				 <&p_clk>, <&p_clk>, <&zx_clk>, <&zx_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 				R8A7792_CLK_HSCIF1 R8A7792_CLK_HSCIF0
 				R8A7792_CLK_SCIF3 R8A7792_CLK_SCIF2
 				R8A7792_CLK_SCIF1 R8A7792_CLK_SCIF0
+				R8A7792_CLK_DU1 R8A7792_CLK_DU0
 			>;
 			clock-output-names = "hscif1", "hscif0", "scif3",
-					     "scif2", "scif1", "scif0";
+					     "scif2", "scif1", "scif0",
+					     "du1", "du0";
 		};
 		mstp8_clks: mstp8_clks at e6150990 {
 			compatible = "renesas,r8a7792-mstp-clocks",
-- 
2.7.0.rc3.207.g0ac5344
