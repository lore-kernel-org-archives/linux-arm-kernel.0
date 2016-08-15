From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Aug 2016 10:55:35 +0200
Subject: [PATCH 16/26] ARM: dts: r8a7792: add VIN clocks
In-Reply-To: <cover.1471251169.git.horms+renesas@verge.net.au>
References: <cover.1471251169.git.horms+renesas@verge.net.au>
Message-ID: <62855bcf15796de1231c93652d385a8b11be75c4.1471251169.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe the VIN[0-5] clocks and their parent, ZG clock in the R8A7792
device  tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 89f248c5cd9e..dbe2f28fee99 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -643,6 +643,13 @@
 			clock-div = <49>;
 			clock-mult = <1>;
 		};
+		zg_clk: zg {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <5>;
+			clock-mult = <1>;
+		};
 
 		/* Gate clocks */
 		mstp1_clks: mstp1_clks at e6150134 {
@@ -702,10 +709,17 @@
 			compatible = "renesas,r8a7792-mstp-clocks",
 				     "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
-			clocks = <&hp_clk>;
+			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
+			         <&zg_clk>, <&zg_clk>, <&hp_clk>;
 			#clock-cells = <1>;
-			clock-indices = <R8A7792_CLK_ETHERAVB>;
-			clock-output-names = "etheravb";
+			clock-indices = <
+				R8A7792_CLK_VIN5 R8A7792_CLK_VIN4
+				R8A7792_CLK_VIN3 R8A7792_CLK_VIN2
+				R8A7792_CLK_VIN1 R8A7792_CLK_VIN0
+				R8A7792_CLK_ETHERAVB
+			>;
+			clock-output-names = "vin5", "vin4", "vin3", "vin2",
+					     "vin1", "vin0", "etheravb";
 		};
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7792-mstp-clocks",
-- 
2.7.0.rc3.207.g0ac5344
