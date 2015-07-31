From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat,  1 Aug 2015 00:58:30 +0200
Subject: [PATCH 9/9] ARM: at91/dt: at91sam9x5dm: add QT1070 touch button
 controller
In-Reply-To: <1438383510-10521-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438383510-10521-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438383510-10521-10-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

The display module for at91sam9x5-ek has a few touch buttons, add support
for those.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9x5dm.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5dm.dtsi b/arch/arm/boot/dts/at91sam9x5dm.dtsi
index 3e6b4a042186..34c089fe0bc0 100644
--- a/arch/arm/boot/dts/at91sam9x5dm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5dm.dtsi
@@ -12,6 +12,18 @@
 / {
 	ahb {
 		apb {
+			i2c0: i2c at f8010000 {
+				qt1070: keyboard at 1b {
+					compatible = "qt1070";
+					reg = <0x1b>;
+					interrupt-parent = <&pioA>;
+					interrupts = <7 0x0>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_qt1070_irq>;
+					wakeup-source;
+				};
+			};
+
 			hlcdc: hlcdc at f8038000 {
 				hlcdc-display-controller {
 					pinctrl-names = "default";
@@ -31,6 +43,15 @@
 				atmel,adc-ts-pressure-threshold = <10000>;
 				status = "okay";
 			};
+
+			pinctrl at fffff400 {
+				board {
+					pinctrl_qt1070_irq: qt1070_irq {
+						atmel,pins =
+							<AT91_PIOA 7 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
+					};
+				};
+			};
 		};
 	};
 
-- 
2.1.4
