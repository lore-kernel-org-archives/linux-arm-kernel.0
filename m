From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 13 Jan 2015 09:37:25 +0800
Subject: [PATCH v3 03/13] ARM: dts: sun9i: Add mmc module clock nodes for A80
In-Reply-To: <1421113055-17867-1-git-send-email-wens@csie.org>
References: <1421113055-17867-1-git-send-email-wens@csie.org>
Message-ID: <1421113055-17867-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmc module clocks are A80 specific module 0 (storage) type clocks.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 4b584cb9c2f0..ddc34676987d 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -219,6 +219,42 @@
 			clock-output-names = "cci400";
 		};
 
+		mmc0_clk: clk at 06000410 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun9i-a80-mmc-clk";
+			reg = <0x06000410 0x4>;
+			clocks = <&osc24M>, <&pll4>;
+			clock-output-names = "mmc0", "mmc0_output",
+					     "mmc0_sample";
+		};
+
+		mmc1_clk: clk at 06000414 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun9i-a80-mmc-clk";
+			reg = <0x06000414 0x4>;
+			clocks = <&osc24M>, <&pll4>;
+			clock-output-names = "mmc1", "mmc1_output",
+					     "mmc1_sample";
+		};
+
+		mmc2_clk: clk at 06000418 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun9i-a80-mmc-clk";
+			reg = <0x06000418 0x4>;
+			clocks = <&osc24M>, <&pll4>;
+			clock-output-names = "mmc2", "mmc2_output",
+					     "mmc2_sample";
+		};
+
+		mmc3_clk: clk at 0600041c {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun9i-a80-mmc-clk";
+			reg = <0x0600041c 0x4>;
+			clocks = <&osc24M>, <&pll4>;
+			clock-output-names = "mmc3", "mmc3_output",
+					     "mmc3_sample";
+		};
+
 		ahb0_gates: clk at 06000580 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun9i-a80-ahb0-gates-clk";
-- 
2.1.4
