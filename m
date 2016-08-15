From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Aug 2016 10:55:23 +0200
Subject: [PATCH 04/26] ARM: dts: r8a7792: add GPIO clocks
In-Reply-To: <cover.1471251169.git.horms+renesas@verge.net.au>
References: <cover.1471251169.git.horms+renesas@verge.net.au>
Message-ID: <4e2b4f6626541dd791d468c9ccd2d0cc72cc0989.1471251169.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe the GPIO clocks in the R8A7792 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 0b746ddd5cd6..da3eb295c6f1 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -370,6 +370,27 @@
 			clock-output-names = "hscif1", "hscif0", "scif3",
 					     "scif2", "scif1", "scif0";
 		};
+		mstp9_clks: mstp9_clks at e6150994 {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
+			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7792_CLK_GPIO7 R8A7792_CLK_GPIO6
+				R8A7792_CLK_GPIO5 R8A7792_CLK_GPIO4
+				R8A7792_CLK_GPIO3 R8A7792_CLK_GPIO2
+				R8A7792_CLK_GPIO1 R8A7792_CLK_GPIO0
+				R8A7792_CLK_GPIO11 R8A7792_CLK_GPIO10
+				R8A7792_CLK_GPIO9 R8A7792_CLK_GPIO8
+			>;
+			clock-output-names =
+				"gpio7", "gpio6", "gpio5", "gpio4",
+				"gpio3", "gpio2", "gpio1", "gpio0",
+				"gpio11", "gpio10", "gpio9", "gpio8";
+		};
 	};
 
 	/* External root clock */
-- 
2.7.0.rc3.207.g0ac5344
