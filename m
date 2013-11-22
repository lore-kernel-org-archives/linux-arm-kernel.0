From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 22 Nov 2013 14:49:53 +0100
Subject: [PATCH 2/2] ARM: at91: at91sam9g45: add i2c pinctrl
In-Reply-To: <1385128193-9963-1-git-send-email-ludovic.desroches@atmel.com>
References: <1385128193-9963-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1385128193-9963-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index cf7de80..dbed3b2 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -143,6 +143,22 @@
 					};
 				};
 
+				i2c0 {
+					pinctrl_i2c0: i2c0-0 {
+						atmel,pins =
+							<AT91_PIOA 21 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA21 periph A TWCK0 */
+							 AT91_PIOA 20 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA20 periph A TWD0 */
+					};
+				};
+
+				i2c1 {
+					pinctrl_i2c1: i2c1-0 {
+						atmel,pins =
+							<AT91_PIOB 11 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB11 periph A TWCK1 */
+							 AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB10 periph A TWD1 */
+					};
+				};
+
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
@@ -542,6 +558,8 @@
 				compatible = "atmel,at91sam9g10-i2c";
 				reg = <0xfff84000 0x100>;
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 6>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -551,6 +569,8 @@
 				compatible = "atmel,at91sam9g10-i2c";
 				reg = <0xfff88000 0x100>;
 				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 6>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
-- 
1.7.9.5
