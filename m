From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Mon, 6 Aug 2018 14:19:48 +0300
Subject: [PATCH v7 3/3] ARM: dts: at91: sama5d2 Xplained: add pin muxing for
 I2S
In-Reply-To: <20180806111948.4522-1-codrin.ciubotariu@microchip.com>
References: <20180806111948.4522-1-codrin.ciubotariu@microchip.com>
Message-ID: <20180806111948.4522-4-codrin.ciubotariu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

This patch sets the pin muxing for the I2S controllers

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
[codrin.ciubotariu at microchip.com: added pin muxing for the second
controller]
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v7:
	- added comments with pin conflicts created by the I2S
	  controllers;
	- explicitly disable the I2S nodes;

Changes in v6:
        - none

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 30 +++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index fcc85d70f36e..518e2b095ccf 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -281,6 +281,12 @@
 				status = "okay";
 			};
 
+			i2s0: i2s at f8050000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2s0_default>;
+				status = "disabled"; /* conflict with can0 */
+			};
+
 			can0: can at f8054000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_can0_default>;
@@ -424,6 +430,24 @@
 					bias-disable;
 				};
 
+				pinctrl_i2s0_default: i2s0_default {
+					pinmux = <PIN_PC1__I2SC0_CK>,
+						 <PIN_PC2__I2SC0_MCK>,
+						 <PIN_PC3__I2SC0_WS>,
+						 <PIN_PC4__I2SC0_DI0>,
+						 <PIN_PC5__I2SC0_DO0>;
+					bias-disable;
+				};
+
+				pinctrl_i2s1_default: i2s1_default {
+					pinmux = <PIN_PA15__I2SC1_CK>,
+						 <PIN_PA14__I2SC1_MCK>,
+						 <PIN_PA16__I2SC1_WS>,
+						 <PIN_PA17__I2SC1_DI0>,
+						 <PIN_PA18__I2SC1_DO0>;
+					bias-disable;
+				};
+
 				pinctrl_key_gpio_default: key_gpio_default {
 					pinmux = <PIN_PB9__GPIO>;
 					bias-pull-up;
@@ -546,6 +570,12 @@
 				status = "okay";
 			};
 
+			i2s1: i2s at fc04c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2s1_default>;
+				status = "disabled"; /* conflict with spi0, sdmmc1 */
+			};
+
 			can1: can at fc050000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_can1_default>;
-- 
2.17.1
