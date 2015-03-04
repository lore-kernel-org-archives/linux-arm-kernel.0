From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 18:26:39 +0100
Subject: [PATCH] ARM: at91/dt: at91-sama5d3_xplained: add gpio-key pinctrl
 property
Message-ID: <1425489999-24664-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wenyou Yang <wenyou.yang@atmel.com>

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index fec1fca2ad66..225c63d003d1 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -188,6 +188,11 @@
 							<AT91_PIOA 19 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
 					};
 
+					pinctrl_key_gpio: key_gpio_0 {
+						atmel,pins =
+							<AT91_PIOE 29 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
+					};
+
 					pinctrl_mmc0_cd: mmc0_cd {
 						atmel,pins =
 							<AT91_PIOE 0 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
@@ -276,6 +281,9 @@
 	gpio_keys {
 		compatible = "gpio-keys";
 
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_key_gpio>;
+
 		bp3 {
 			label = "PB_USER";
 			gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
-- 
2.1.3
