From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Jan 2014 12:10:47 +0100
Subject: [PATCH v2 2/5] ARM: sun6i: dt: Add PLL6 and SPI module clocks
In-Reply-To: <1390993850-9054-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1390993850-9054-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1390993850-9054-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The module clocks in the A31 are still compatible with the A10 one. Add the SPI
module clocks and the PLL6 in the device tree to allow their use by the SPI
controllers.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 46 ++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 5256ad9..0eea325 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -73,16 +73,12 @@
 			clocks = <&osc24M>;
 		};
 
-		/*
-		 * This is a dummy clock, to be used as placeholder on
-		 * other mux clocks when a specific parent clock is not
-		 * yet implemented. It should be dropped when the driver
-		 * is complete.
-		 */
-		pll6: pll6 {
+		pll6: clk at 01c20028 {
 			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <0>;
+			compatible = "allwinner,sun6i-a31-pll6-clk";
+			reg = <0x01c20028 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll6";
 		};
 
 		cpu: cpu at 01c20050 {
@@ -182,6 +178,38 @@
 					"apb2_uart1", "apb2_uart2", "apb2_uart3",
 					"apb2_uart4", "apb2_uart5";
 		};
+
+		spi0_clk: clk at 01c200a0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200a0 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "spi0";
+		};
+
+		spi1_clk: clk at 01c200a4 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200a4 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "spi1";
+		};
+
+		spi2_clk: clk at 01c200a8 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200a8 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "spi2";
+		};
+
+		spi3_clk: clk at 01c200ac {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200ac 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "spi3";
+		};
 	};
 
 	soc at 01c00000 {
-- 
1.8.4.2
