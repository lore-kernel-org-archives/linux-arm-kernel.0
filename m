From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 13 Apr 2014 09:19:04 +0400
Subject: [PATCH 01/10] ARM: dts: imx51-babbage: Use separate pingroup for
 gpio-keys
Message-ID: <1397366353-29395-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves GPIOs definitions for "gpio-keys" into a separate
pingroup.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-babbage.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 2dda06b..eddb62d 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -82,6 +82,8 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
 
 		power {
 			label = "Power Button";
@@ -333,7 +335,6 @@
 				MX51_PAD_GPIO1_1__SD1_WP     0x20d5
 				MX51_PAD_GPIO1_5__GPIO1_5    0x100
 				MX51_PAD_GPIO1_6__GPIO1_6    0x100
-				MX51_PAD_EIM_A27__GPIO2_21   0x5
 				MX51_PAD_CSPI1_SS0__GPIO4_24 0x85
 				MX51_PAD_CSPI1_SS1__GPIO4_25 0x85
 				MX51_PAD_CSPI1_RDY__GPIO4_26 0x80000000
@@ -402,6 +403,12 @@
 			>;
 		};
 
+		pinctrl_gpio_keys: gpiokeysgrp {
+			fsl,pins = <
+				MX51_PAD_EIM_A27__GPIO2_21		0x5
+			>;
+		};
+
 		pinctrl_gpio_leds: gpioledsgrp {
 			fsl,pins = <
 				MX51_PAD_EIM_D22__GPIO2_6		0x80000000
-- 
1.8.3.2
