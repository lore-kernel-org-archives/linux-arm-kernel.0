From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 23 Dec 2013 00:32:42 -0300
Subject: [PATCH v3 11/13] ARM: sun5i: dt: mod0 clocks
In-Reply-To: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
References: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1387769564-12894-12-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds all the mod0 clocks available on A10 and A13. The list
has been constructed by looking at the Allwinner code release for A10S
and A13.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 88 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 88 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 86e06e4..5012c27 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -173,6 +173,94 @@
 				"apb1_i2c2", "apb1_uart0", "apb1_uart1",
 				"apb1_uart2", "apb1_uart3";
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
+		ir0_clk: clk at 01c200b0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200b0 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "ir0";
+		};
 	};
 
 	soc at 01c00000 {
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index cded3c7..c46ac65 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -170,6 +170,94 @@
 			clock-output-names = "apb1_i2c0", "apb1_i2c1",
 				"apb1_i2c2", "apb1_uart1", "apb1_uart3";
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
+		ir0_clk: clk at 01c200b0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200b0 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+			clock-output-names = "ir0";
+		};
 	};
 
 	soc at 01c00000 {
-- 
1.8.5.2
