From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 21 Nov 2018 07:03:44 +0000
Subject: [PATCH] ARM: dts: imx6sll-evk: add debug LED support
Message-ID: <1542783500-19546-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6SLL EVK board, there is a debug LED controlled
by MX6SLL_PAD_EPDC_VCOM1__GPIO2_IO04 pin, add support
for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll-evk.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index c8e1155..9c90cbd 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -31,6 +31,18 @@
 		status = "okay";
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led>;
+
+		user {
+			label = "debug";
+			gpios = <&gpio2 4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
 	reg_usb_otg1_vbus: regulator-otg1-vbus {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -455,6 +467,12 @@
 		>;
 	};
 
+	pinctrl_led: ledgrp {
+		fsl,pins = <
+			MX6SLL_PAD_EPDC_VCOM1__GPIO2_IO04	0x17059
+		>;
+	};
+
 	pinctrl_pwm1: pmw1grp {
 		fsl,pins = <
 			MX6SLL_PAD_PWM1__PWM1_OUT   0x110b0
-- 
2.7.4
