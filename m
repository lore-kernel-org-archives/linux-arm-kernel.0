From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 1 Mar 2016 15:02:37 +0100
Subject: [PATCH 3/3] ARM: dts: at91: sama5d2 Xplained: add leds node
In-Reply-To: <cover.1456840819.git.nicolas.ferre@atmel.com>
References: <cover.1456840819.git.nicolas.ferre@atmel.com>
Message-ID: <3d95be152295ec59381d64e984d63f62fad6abc3.1456840819.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wenyou Yang <wenyou.yang@atmel.com>

Add the three leds on the sama5d2 Xplained board with their pinctrl node.
The blue led is positioned with the "heartbeat" trigger.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
[nicolas.ferre at atmel.com: add commit message and adapt to newer kernel]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index d20d4033d64c..2636b9e2d124 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -307,6 +307,13 @@
 					bias-pull-up;
 				};
 
+				pinctrl_led_gpio_default: led_gpio_default {
+					pinmux = <PIN_PB0__GPIO>,
+						 <PIN_PB5__GPIO>,
+						 <PIN_PB6__GPIO>;
+					bias-pull-up;
+				};
+
 				pinctrl_macb0_default: macb0_default {
 					pinmux = <PIN_PB14__GTXCK>,
 						 <PIN_PB15__GTXEN>,
@@ -418,4 +425,27 @@
 			linux,code = <0x104>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led_gpio_default>;
+		status = "okay";
+
+		red {
+			label = "red";
+			gpios = <&pioA 38 GPIO_ACTIVE_LOW>;
+		};
+
+		green {
+			label = "green";
+			gpios = <&pioA 37 GPIO_ACTIVE_LOW>;
+		};
+
+		blue {
+			label = "blue";
+			gpios = <&pioA 32 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
 };
-- 
2.1.3
