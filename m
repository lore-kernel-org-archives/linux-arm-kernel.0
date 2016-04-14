From: slemieux.tyco@gmail.com (slemieux.tyco at gmail.com)
Date: Thu, 14 Apr 2016 08:20:35 -0400
Subject: [PATCH 1/3] arm: dts: lpc32xx: add clock properties to spi nodes
In-Reply-To: <1460636437-21764-1-git-send-email-slemieux.tyco@gmail.com>
References: <1460636437-21764-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <1460636437-21764-2-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

The change adds clock properties to spi peripheral devices,
clock ids are taken from dt-bindings/clock/lpc32xx-clock.h

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index c58d8da..0b6a643 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -173,6 +173,8 @@
 			spi1: spi at 20088000 {
 				compatible = "nxp,lpc3220-spi";
 				reg = <0x20088000 0x1000>;
+				clocks = <&clk LPC32XX_CLK_SPI1>;
+				clock-names = "apb_pclk";
 			};
 
 			ssp1: ssp at 2008c000 {
@@ -186,6 +188,8 @@
 			spi2: spi at 20090000 {
 				compatible = "nxp,lpc3220-spi";
 				reg = <0x20090000 0x1000>;
+				clocks = <&clk LPC32XX_CLK_SPI2>;
+				clock-names = "apb_pclk";
 			};
 
 			i2s0: i2s at 20094000 {
-- 
1.8.3.1
