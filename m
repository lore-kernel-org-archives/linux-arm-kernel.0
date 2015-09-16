From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 16 Sep 2015 17:37:03 +0200
Subject: [PATCH v2 7/7] ARM: at91/dt: sama5d2 Xplained: add device pin muxing
In-Reply-To: <1442417823-15850-1-git-send-email-ludovic.desroches@atmel.com>
References: <1442417823-15850-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1442417823-15850-8-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device pin muxing for the sama5d2 Xplained board.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 61 +++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index e8d63afd..dc23979 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -44,6 +44,7 @@
  */
 /dts-v1/;
 #include "sama5d2.dtsi"
+#include "sama5d2-pinfunc.h"
 
 / {
 	model = "Atmel SAMA5D2 Xplained";
@@ -92,6 +93,8 @@
 
 		apb {
 			spi0: spi at f8000000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_spi0_default>;
 				status = "okay";
 
 				m25p80 at 0 {
@@ -102,25 +105,35 @@
 			};
 
 			macb0: ethernet at f8008000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_macb0_default>;
 				phy-mode = "rmii";
 				status = "okay";
 			};
 
 			uart1: serial at f8020000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart1_default>;
 				status = "okay";
 			};
 
 			i2c0: i2c at f8028000 {
 				dmas = <0>, <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c0_default>;
 				status = "okay";
 			};
 
 			uart3: serial at fc008000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart3_default>;
 				status = "okay";
 			};
 
 			i2c1: i2c at fc028000 {
 				dmas = <0>, <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c1_default>;
 				status = "okay";
 
 				at24 at 54 {
@@ -129,6 +142,54 @@
 					pagesize = <16>;
 				};
 			};
+
+			pinctrl at fc038000 {
+				pinctrl_i2c0_default: i2c0_default {
+					pinmux = <PIN_PD21__TWD0>,
+						 <PIN_PD22__TWCK0>;
+					bias-disable;
+				};
+
+				pinctrl_i2c1_default: i2c1_default {
+					pinmux = <PIN_PD4__TWD1>,
+						 <PIN_PD5__TWCK1>;
+					bias-disable;
+				};
+
+				pinctrl_macb0_default: macb0_default {
+					pinmux = <PIN_PB14__GTXCK>,
+						 <PIN_PB15__GTXEN>,
+						 <PIN_PB16__GRXDV>,
+						 <PIN_PB17__GRXER>,
+						 <PIN_PB18__GRX0>,
+						 <PIN_PB19__GRX1>,
+						 <PIN_PB20__GTX0>,
+						 <PIN_PB21__GTX1>,
+						 <PIN_PB22__GMDC>,
+						 <PIN_PB23__GMDIO>;
+					bias-disable;
+				};
+
+				pinctrl_spi0_default: spi0_default {
+					pinmux = <PIN_PA14__SPI0_SPCK>,
+						 <PIN_PA15__SPI0_MOSI>,
+						 <PIN_PA16__SPI0_MISO>,
+						 <PIN_PA17__SPI0_NPCS0>;
+					bias-disable;
+				};
+
+				pinctrl_uart1_default: uart1_default {
+					pinmux = <PIN_PD2__URXD1>,
+						 <PIN_PD3__UTXD1>;
+					bias-disable;
+				};
+
+				pinctrl_uart3_default: uart3_default {
+					pinmux = <PIN_PB11__URXD3>,
+						 <PIN_PB12__UTXD3>;
+					bias-disable;
+				};
+			};
 		};
 	};
 };
-- 
2.5.0
