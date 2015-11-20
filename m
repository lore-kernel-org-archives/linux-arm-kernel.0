From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:05:06 +0200
Subject: [PATCH 06/11] arm: dts: lpc32xx: add clock properties to device nodes
In-Reply-To: <1447981511-29653-1-git-send-email-vz@mleia.com>
References: <1447981511-29653-1-git-send-email-vz@mleia.com>
Message-ID: <1447981511-29653-7-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds clock properties to all described peripheral devices,
clock ids are taken from dt-bindings/clock/lpc32xx-clock.h

Some existing drivers expect to get clock names, in those cases
clock-names are added as well.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index 65023c1..792468e 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -13,6 +13,8 @@
 
 #include "skeleton.dtsi"
 
+#include <dt-bindings/clock/lpc32xx-clock.h>
+
 / {
 	compatible = "nxp,lpc3220";
 	interrupt-parent = <&mic>;
@@ -57,6 +59,7 @@
 		slc: flash at 20020000 {
 			compatible = "nxp,lpc3220-slc";
 			reg = <0x20020000 0x1000>;
+			clocks = <&clk LPC32XX_CLK_SLC>;
 			status = "disabled";
 		};
 
@@ -64,6 +67,7 @@
 			compatible = "nxp,lpc3220-mlc";
 			reg = <0x200a8000 0x11000>;
 			interrupts = <11 0>;
+			clocks = <&clk LPC32XX_CLK_MLC>;
 			status = "disabled";
 		};
 
@@ -71,6 +75,8 @@
 			compatible = "arm,pl080", "arm,primecell";
 			reg = <0x31000000 0x1000>;
 			interrupts = <0x1c 0>;
+			clocks = <&clk LPC32XX_CLK_DMA>;
+			clock-names = "apb_pclk";
 		};
 
 		usb {
@@ -110,6 +116,8 @@
 			compatible = "arm,pl110", "arm,primecell";
 			reg = <0x31040000 0x1000>;
 			interrupts = <0x0e 0>;
+			clocks = <&clk LPC32XX_CLK_LCD>;
+			clock-names = "apb_pclk";
 			status = "disabled";
 		};
 
@@ -117,11 +125,14 @@
 			compatible = "nxp,lpc-eth";
 			reg = <0x31060000 0x1000>;
 			interrupts = <0x1d 0>;
+			clocks = <&clk LPC32XX_CLK_MAC>;
 		};
 
 		emc: memory-controller at 31080000 {
 			compatible = "arm,pl175", "arm,primecell";
 			reg = <0x31080000 0x1000>;
+			clocks = <&clk LPC32XX_CLK_DDRAM>, <&clk LPC32XX_CLK_DDRAM>;
+			clock-names = "mpmcclk", "apb_pclk";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
@@ -142,6 +153,8 @@
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x20084000 0x1000>;
 				interrupts = <0x14 0>;
+				clocks = <&clk LPC32XX_CLK_SSP0>;
+				clock-names = "apb_pclk";
 			};
 
 			spi1: spi at 20088000 {
@@ -153,6 +166,8 @@
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x2008c000 0x1000>;
 				interrupts = <0x15 0>;
+				clocks = <&clk LPC32XX_CLK_SSP1>;
+				clock-names = "apb_pclk";
 			};
 
 			spi2: spi at 20090000 {
@@ -169,6 +184,8 @@
 				compatible = "arm,pl18x", "arm,primecell";
 				reg = <0x20098000 0x1000>;
 				interrupts = <0x0f 0>, <0x0d 0>;
+				clocks = <&clk LPC32XX_CLK_SD>;
+				clock-names = "apb_pclk";
 				status = "disabled";
 			};
 
@@ -185,6 +202,7 @@
 				interrupts = <9 0>;
 				clock-frequency = <13000000>;
 				reg-shift = <2>;
+				clocks = <&clk LPC32XX_CLK_UART5>;
 				status = "disabled";
 			};
 
@@ -194,6 +212,7 @@
 				interrupts = <7 0>;
 				clock-frequency = <13000000>;
 				reg-shift = <2>;
+				clocks = <&clk LPC32XX_CLK_UART3>;
 				status = "disabled";
 			};
 
@@ -203,6 +222,7 @@
 				interrupts = <8 0>;
 				clock-frequency = <13000000>;
 				reg-shift = <2>;
+				clocks = <&clk LPC32XX_CLK_UART4>;
 				status = "disabled";
 			};
 
@@ -212,6 +232,7 @@
 				interrupts = <10 0>;
 				clock-frequency = <13000000>;
 				reg-shift = <2>;
+				clocks = <&clk LPC32XX_CLK_UART6>;
 				status = "disabled";
 			};
 
@@ -222,6 +243,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				pnx,timeout = <0x64>;
+				clocks = <&clk LPC32XX_CLK_I2C1>;
 			};
 
 			i2c2: i2c at 400A8000 {
@@ -231,6 +253,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				pnx,timeout = <0x64>;
+				clocks = <&clk LPC32XX_CLK_I2C2>;
 			};
 
 			mpwm: mpwm at 400E8000 {
@@ -302,6 +325,7 @@
 				compatible = "nxp,lpc3220-rtc";
 				reg = <0x40024000 0x1000>;
 				interrupts = <0x34 0>;
+				clocks = <&clk LPC32XX_CLK_RTC>;
 			};
 
 			gpio: gpio at 40028000 {
@@ -315,6 +339,8 @@
 				compatible = "nxp,lpc3220-timer";
 				reg = <0x4002C000 0x1000>;
 				interrupts = <0x3 0>;
+				clocks = <&clk LPC32XX_CLK_TIMER4>;
+				clock-names = "timerclk";
 				status = "disabled";
 			};
 
@@ -322,17 +348,22 @@
 				compatible = "nxp,lpc3220-timer";
 				reg = <0x40030000 0x1000>;
 				interrupts = <0x4 0>;
+				clocks = <&clk LPC32XX_CLK_TIMER5>;
+				clock-names = "timerclk";
 				status = "disabled";
 			};
 
 			watchdog: watchdog at 4003C000 {
 				compatible = "nxp,pnx4008-wdt";
 				reg = <0x4003C000 0x1000>;
+				clocks = <&clk LPC32XX_CLK_WDOG>;
 			};
 
 			timer0: timer at 40044000 {
 				compatible = "nxp,lpc3220-timer";
 				reg = <0x40044000 0x1000>;
+				clocks = <&clk LPC32XX_CLK_TIMER0>;
+				clock-names = "timerclk";
 				interrupts = <0x10 0>;
 			};
 
@@ -347,6 +378,7 @@
 				compatible = "nxp,lpc3220-adc";
 				reg = <0x40048000 0x1000>;
 				interrupts = <0x27 0>;
+				clocks = <&clk LPC32XX_CLK_ADC>;
 				status = "disabled";
 			};
 
@@ -354,6 +386,7 @@
 				compatible = "nxp,lpc3220-tsc";
 				reg = <0x40048000 0x1000>;
 				interrupts = <0x27 0>;
+				clocks = <&clk LPC32XX_CLK_ADC>;
 				status = "disabled";
 			};
 
@@ -361,6 +394,8 @@
 				compatible = "nxp,lpc3220-timer";
 				reg = <0x4004C000 0x1000>;
 				interrupts = <0x11 0>;
+				clocks = <&clk LPC32XX_CLK_TIMER1>;
+				clock-names = "timerclk";
 			};
 
 			key: key at 40050000 {
@@ -374,18 +409,22 @@
 				compatible = "nxp,lpc3220-timer";
 				reg = <0x40058000 0x1000>;
 				interrupts = <0x12 0>;
+				clocks = <&clk LPC32XX_CLK_TIMER2>;
+				clock-names = "timerclk";
 				status = "disabled";
 			};
 
 			pwm1: pwm at 4005C000 {
 				compatible = "nxp,lpc3220-pwm";
 				reg = <0x4005C000 0x4>;
+				clocks = <&clk LPC32XX_CLK_PWM1>;
 				status = "disabled";
 			};
 
 			pwm2: pwm at 4005C004 {
 				compatible = "nxp,lpc3220-pwm";
 				reg = <0x4005C004 0x4>;
+				clocks = <&clk LPC32XX_CLK_PWM2>;
 				status = "disabled";
 			};
 
@@ -393,6 +432,8 @@
 				compatible = "nxp,lpc3220-timer";
 				reg = <0x40060000 0x1000>;
 				interrupts = <0x13 0>;
+				clocks = <&clk LPC32XX_CLK_TIMER3>;
+				clock-names = "timerclk";
 				status = "disabled";
 			};
 		};
-- 
2.1.4
