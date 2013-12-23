From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 23 Dec 2013 00:32:43 -0300
Subject: [PATCH v3 12/13] ARM: sun7i: dt: mod0 clocks
In-Reply-To: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
References: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1387769564-12894-13-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds all the mod0 clocks available on A20 to its device
tree. This list was created by looking at AW's code release.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 120 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 7949028..9a2e356 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -174,6 +174,126 @@
 				"apb1_uart2", "apb1_uart3", "apb1_uart4",
 				"apb1_uart5", "apb1_uart6", "apb1_uart7";
 		};
+
+		nand_clk: clk at 01c20080 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c20080 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "nand";
+		};
+
+		ms_clk: clk at 01c20084 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c20084 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "ms";
+		};
+
+		mmc0_clk: clk at 01c20088 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "mmc0";
+		};
+
+		mmc1_clk: clk at 01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "mmc1";
+		};
+
+		mmc2_clk: clk at 01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "mmc2";
+		};
+
+		mmc3_clk: clk at 01c20094 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c20094 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "mmc3";
+		};
+
+		ts_clk: clk at 01c20098 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c20098 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "ts";
+		};
+
+		ss_clk: clk at 01c2009c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c2009c 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "ss";
+		};
+
+		spi0_clk: clk at 01c200a0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200a0 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "spi0";
+		};
+
+		spi1_clk: clk at 01c200a4 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200a4 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "spi1";
+		};
+
+		spi2_clk: clk at 01c200a8 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200a8 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "spi2";
+		};
+
+		pata_clk: clk at 01c200ac {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200ac 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "pata";
+		};
+
+		ir0_clk: clk at 01c200b0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200b0 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "ir0";
+		};
+
+		ir1_clk: clk at 01c200b4 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200b4 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "ir1";
+		};
+
+		spi3_clk: clk at 01c200d4 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200d4 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "spi3";
+		};
 	};
 
 	soc at 01c00000 {
-- 
1.8.5.2
