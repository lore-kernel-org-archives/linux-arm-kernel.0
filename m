From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 30 Jun 2014 17:41:29 +0200
Subject: [PATCH 2/2] ARM: efm32: switch to vendor,device compatible strings
In-Reply-To: <20140630154030.GJ14781@pengutronix.de>
References: <20140630154030.GJ14781@pengutronix.de>
Message-ID: <1404142889-20740-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mainline drivers were fixed in commits

 - 4ea8dafd2475 (serial: efm32: use $vendor,$device scheme for
   compatible string)
 - 12f6dd860cf8 (spi: efm32: use $vendor,$device scheme for compatible
   string)
 - 63cc122381bd (clocksource: efm32: use $vendor,$device scheme for
   compatible string)

to also support these compatible strings.

For the other affected peripherals (adc and gpio) there are no drivers in
mainline yet.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/efm32gg.dtsi | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/efm32gg.dtsi b/arch/arm/boot/dts/efm32gg.dtsi
index 106d505c5d3d..c747983771c7 100644
--- a/arch/arm/boot/dts/efm32gg.dtsi
+++ b/arch/arm/boot/dts/efm32gg.dtsi
@@ -23,7 +23,7 @@
 
 	soc {
 		adc: adc at 40002000 {
-			compatible = "efm32,adc";
+			compatible = "energymicro,efm32-adc";
 			reg = <0x40002000 0x400>;
 			interrupts = <7>;
 			clocks = <&cmu clk_HFPERCLKADC0>;
@@ -31,7 +31,7 @@
 		};
 
 		gpio: gpio at 40006000 {
-			compatible = "efm32,gpio";
+			compatible = "energymicro,efm32-gpio";
 			reg = <0x40006000 0x1000>;
 			interrupts = <1 11>;
 			gpio-controller;
@@ -45,7 +45,7 @@
 		i2c0: i2c at 4000a000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "efm32,i2c";
+			compatible = "energymicro,efm32-i2c";
 			reg = <0x4000a000 0x400>;
 			interrupts = <9>;
 			clocks = <&cmu clk_HFPERCLKI2C0>;
@@ -56,7 +56,7 @@
 		i2c1: i2c at 4000a400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "efm32,i2c";
+			compatible = "energymicro,efm32-i2c";
 			reg = <0x4000a400 0x400>;
 			interrupts = <10>;
 			clocks = <&cmu clk_HFPERCLKI2C1>;
@@ -67,7 +67,7 @@
 		spi0: spi at 4000c000 { /* USART0 */
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "efm32,spi";
+			compatible = "energymicro,efm32-spi";
 			reg = <0x4000c000 0x400>;
 			interrupts = <3 4>;
 			clocks = <&cmu clk_HFPERCLKUSART0>;
@@ -77,7 +77,7 @@
 		spi1: spi at 4000c400 { /* USART1 */
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "efm32,spi";
+			compatible = "energymicro,efm32-spi";
 			reg = <0x4000c400 0x400>;
 			interrupts = <15 16>;
 			clocks = <&cmu clk_HFPERCLKUSART1>;
@@ -87,7 +87,7 @@
 		spi2: spi at 4000c800 { /* USART2 */
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "efm32,spi";
+			compatible = "energymicro,efm32-spi";
 			reg = <0x4000c800 0x400>;
 			interrupts = <18 19>;
 			clocks = <&cmu clk_HFPERCLKUSART2>;
@@ -95,7 +95,7 @@
 		};
 
 		uart0: uart at 4000c000 { /* USART0 */
-			compatible = "efm32,uart";
+			compatible = "energymicro,efm32-uart";
 			reg = <0x4000c000 0x400>;
 			interrupts = <3 4>;
 			clocks = <&cmu clk_HFPERCLKUSART0>;
@@ -103,7 +103,7 @@
 		};
 
 		uart1: uart at 4000c400 { /* USART1 */
-			compatible = "efm32,uart";
+			compatible = "energymicro,efm32-uart";
 			reg = <0x4000c400 0x400>;
 			interrupts = <15 16>;
 			clocks = <&cmu clk_HFPERCLKUSART1>;
@@ -111,7 +111,7 @@
 		};
 
 		uart2: uart at 4000c800 { /* USART2 */
-			compatible = "efm32,uart";
+			compatible = "energymicro,efm32-uart";
 			reg = <0x4000c800 0x400>;
 			interrupts = <18 19>;
 			clocks = <&cmu clk_HFPERCLKUSART2>;
@@ -119,7 +119,7 @@
 		};
 
 		uart3: uart at 4000e000 { /* UART0 */
-			compatible = "efm32,uart";
+			compatible = "energymicro,efm32-uart";
 			reg = <0x4000e000 0x400>;
 			interrupts = <20 21>;
 			clocks = <&cmu clk_HFPERCLKUART0>;
@@ -127,7 +127,7 @@
 		};
 
 		uart4: uart at 4000e400 { /* UART1 */
-			compatible = "efm32,uart";
+			compatible = "energymicro,efm32-uart";
 			reg = <0x4000e400 0x400>;
 			interrupts = <22 23>;
 			clocks = <&cmu clk_HFPERCLKUART1>;
@@ -135,28 +135,28 @@
 		};
 
 		timer0: timer at 40010000 {
-			compatible = "efm32,timer";
+			compatible = "energymicro,efm32-timer";
 			reg = <0x40010000 0x400>;
 			interrupts = <2>;
 			clocks = <&cmu clk_HFPERCLKTIMER0>;
 		};
 
 		timer1: timer at 40010400 {
-			compatible = "efm32,timer";
+			compatible = "energymicro,efm32-timer";
 			reg = <0x40010400 0x400>;
 			interrupts = <12>;
 			clocks = <&cmu clk_HFPERCLKTIMER1>;
 		};
 
 		timer2: timer at 40010800 {
-			compatible = "efm32,timer";
+			compatible = "energymicro,efm32-timer";
 			reg = <0x40010800 0x400>;
 			interrupts = <13>;
 			clocks = <&cmu clk_HFPERCLKTIMER2>;
 		};
 
 		timer3: timer at 40010c00 {
-			compatible = "efm32,timer";
+			compatible = "energymicro,efm32-timer";
 			reg = <0x40010c00 0x400>;
 			interrupts = <14>;
 			clocks = <&cmu clk_HFPERCLKTIMER3>;
-- 
2.0.0
