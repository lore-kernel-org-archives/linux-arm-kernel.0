From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Aug 2016 10:55:31 +0200
Subject: [PATCH 12/26] ARM: dts: r8a7792: add SD clocks
In-Reply-To: <cover.1471251169.git.horms+renesas@verge.net.au>
References: <cover.1471251169.git.horms+renesas@verge.net.au>
Message-ID: <fe683922cb436097ac5b1f65148fa0db3a6735a3.1471251169.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe the SDHI0 clock and its parent, SD clock in the R8A7792 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 1b96bf6393fb..4148c5867c07 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -535,6 +535,13 @@
 			clock-div = <8>;
 			clock-mult = <1>;
 		};
+		sd_clk: sd {
+			compatible = "fixed-factor-clock";
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+		};
 		rcan_clk: rcan {
 			compatible = "fixed-factor-clock";
 			clocks = <&pll1_div2_clk>;
@@ -564,6 +571,15 @@
 			>;
 			clock-output-names = "sys-dmac1", "sys-dmac0";
 		};
+		mstp3_clks: mstp3_clks at e615013c {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
+			clocks = <&sd_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <R8A7792_CLK_SDHI0>;
+			clock-output-names = "sdhi0";
+		};
 		mstp4_clks: mstp4_clks at e6150140 {
 			compatible = "renesas,r8a7792-mstp-clocks",
 				     "renesas,cpg-mstp-clocks";
-- 
2.7.0.rc3.207.g0ac5344
