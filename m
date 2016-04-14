From: slemieux.tyco@gmail.com (slemieux.tyco at gmail.com)
Date: Thu, 14 Apr 2016 08:20:36 -0400
Subject: [PATCH 2/3] arm: dts: lpc32xx: disabled ssp0/spi1 & ssp1/spi2 by
 default
In-Reply-To: <1460636437-21764-1-git-send-email-slemieux.tyco@gmail.com>
References: <1460636437-21764-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <1460636437-21764-3-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

The SSP0/SPI1 and SSP1/SPI2 shared pinout and should be disable by default.

Board specific dts should enable them, as needed.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index 0b6a643..aa5cb43 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -162,12 +162,17 @@
 			compatible = "simple-bus";
 			ranges = <0x20000000 0x20000000 0x30000000>;
 
+			/*
+			 * ssp0 and spi1 are shared pins;
+			 * enable one in your board dts, as needed.
+			 */
 			ssp0: ssp at 20084000 {
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x20084000 0x1000>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk LPC32XX_CLK_SSP0>;
 				clock-names = "apb_pclk";
+				status = "disabled";
 			};
 
 			spi1: spi at 20088000 {
@@ -175,14 +180,20 @@
 				reg = <0x20088000 0x1000>;
 				clocks = <&clk LPC32XX_CLK_SPI1>;
 				clock-names = "apb_pclk";
+				status = "disabled";
 			};
 
+			/*
+			 * ssp1 and spi2 are shared pins;
+			 * enable one in your board dts, as needed.
+			 */
 			ssp1: ssp at 2008c000 {
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x2008c000 0x1000>;
 				interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk LPC32XX_CLK_SSP1>;
 				clock-names = "apb_pclk";
+				status = "disabled";
 			};
 
 			spi2: spi at 20090000 {
@@ -190,6 +201,7 @@
 				reg = <0x20090000 0x1000>;
 				clocks = <&clk LPC32XX_CLK_SPI2>;
 				clock-names = "apb_pclk";
+				status = "disabled";
 			};
 
 			i2s0: i2s at 20094000 {
-- 
1.8.3.1
