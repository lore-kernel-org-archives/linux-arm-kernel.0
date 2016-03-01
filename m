From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 1 Mar 2016 15:02:36 +0100
Subject: [PATCH 2/3] ARM: dts: at91: sama5d2 Xplained: add user push button
In-Reply-To: <cover.1456840819.git.nicolas.ferre@atmel.com>
References: <cover.1456840819.git.nicolas.ferre@atmel.com>
Message-ID: <ba19cb71b37ffe278d5b53b35fdaf8fa42e22e01.1456840819.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Add the push button named "PB USER" with code 0x104. Associated pinctrl node is
also added.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 382ccfb4a2b6..d20d4033d64c 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -302,6 +302,11 @@
 					bias-disable;
 				};
 
+				pinctrl_key_gpio_default: key_gpio_default {
+					pinmux = <PIN_PB9__GPIO>;
+					bias-pull-up;
+				};
+
 				pinctrl_macb0_default: macb0_default {
 					pinmux = <PIN_PB14__GTXCK>,
 						 <PIN_PB15__GTXEN>,
@@ -400,4 +405,17 @@
 			};
 		};
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_key_gpio_default>;
+
+		bp1 {
+			label = "PB_USER";
+			gpios = <&pioA 41 GPIO_ACTIVE_LOW>;
+			linux,code = <0x104>;
+		};
+	};
 };
-- 
2.1.3
