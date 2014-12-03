From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 Dec 2014 14:35:57 +0800
Subject: [PATCH 02/10] ARM: dts: sun9i: Add mmc module clock nodes for A80
In-Reply-To: <1417588565-26215-1-git-send-email-wens@csie.org>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
Message-ID: <1417588565-26215-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmc module clocks are A80 specific module 0 (storage) type clocks.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 494714f..33d18dc 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -215,6 +215,38 @@
 			clock-output-names = "cci400";
 		};
 
+		mmc0_clk: clk at 06000410 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun9i-a80-mod0-clk";
+			reg = <0x06000410 0x4>;
+			clocks = <&osc24M>, <&pll4>;
+			clock-output-names = "mmc0";
+		};
+
+		mmc1_clk: clk at 06000414 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun9i-a80-mod0-clk";
+			reg = <0x06000414 0x4>;
+			clocks = <&osc24M>, <&pll4>;
+			clock-output-names = "mmc1";
+		};
+
+		mmc2_clk: clk at 06000418 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun9i-a80-mod0-clk";
+			reg = <0x06000418 0x4>;
+			clocks = <&osc24M>, <&pll4>;
+			clock-output-names = "mmc2";
+		};
+
+		mmc3_clk: clk at 0600041c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun9i-a80-mod0-clk";
+			reg = <0x0600041c 0x4>;
+			clocks = <&osc24M>, <&pll4>;
+			clock-output-names = "mmc3";
+		};
+
 		ahb0_gates: clk at 06000580 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun9i-a80-ahb0-gates-clk";
-- 
2.1.3
