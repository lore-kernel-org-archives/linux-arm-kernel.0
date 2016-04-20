From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed, 20 Apr 2016 09:20:58 -0400
Subject: [PATCH v2 1/3] ARM: dts: lpc32xx: add clock properties to spi nodes
In-Reply-To: <1461158460-2946-1-git-send-email-slemieux.tyco@gmail.com>
References: <1461158460-2946-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <1461158460-2946-2-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

The change adds clock properties to spi peripheral devices,
clock ids are taken from dt-bindings/clock/lpc32xx-clock.h

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index d7b84cd..1b2f351 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -173,6 +173,7 @@
 			spi1: spi at 20088000 {
 				compatible = "nxp,lpc3220-spi";
 				reg = <0x20088000 0x1000>;
+				clocks = <&clk LPC32XX_CLK_SPI1>;
 			};
 
 			ssp1: ssp at 2008c000 {
@@ -186,6 +187,7 @@
 			spi2: spi at 20090000 {
 				compatible = "nxp,lpc3220-spi";
 				reg = <0x20090000 0x1000>;
+				clocks = <&clk LPC32XX_CLK_SPI2>;
 			};
 
 			i2s0: i2s at 20094000 {
-- 
1.8.3.1
