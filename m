From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed,  5 Sep 2018 15:46:12 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabreauto: add gpio keys support
Message-ID: <1536133572-2138-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i.MX6QDL SabreAuto board's gpio keys support, there
are 5 gpio keys on base board:

SW3: KEY_HOME;
SW4: KEY_BACK;
SW5: KEY_PROGRAM;
SW6: KEY_VOLUMEUP;
SW7: KEY_VOLUMEDOWN;

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 9f11f1f..246af86 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -4,6 +4,7 @@
 // Copyright 2011 Linaro Ltd.
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	chosen {
@@ -25,6 +26,47 @@
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		home {
+			label = "Home";
+			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOME>;
+			wakeup-source;
+		};
+
+		back {
+			label = "Back";
+			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+			wakeup-source;
+		};
+
+		program {
+			label = "Program";
+			gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_PROGRAM>;
+			wakeup-source;
+		};
+
+		volume-up {
+			label = "Volume Up";
+			gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
+		};
+
+		volume-down {
+			label = "Volume Down";
+			gpios = <&gpio5 14 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			wakeup-source;
+		};
+	};
+
 	clocks {
 		codec_osc: anaclk2 {
 			compatible = "fixed-clock";
@@ -446,6 +488,16 @@
 			>;
 		};
 
+		pinctrl_gpio_keys: gpiokeysgrp {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__GPIO1_IO11		0x1b0b0
+				MX6QDL_PAD_SD2_DAT3__GPIO1_IO12		0x1b0b0
+				MX6QDL_PAD_SD4_DAT4__GPIO2_IO12		0x1b0b0
+				MX6QDL_PAD_SD4_DAT7__GPIO2_IO15		0x1b0b0
+				MX6QDL_PAD_DISP0_DAT20__GPIO5_IO14	0x1b0b0
+			>;
+		};
+
 		pinctrl_gpio_leds: gpioledsgrp {
 			fsl,pins = <
 				MX6QDL_PAD_DISP0_DAT21__GPIO5_IO15	0x80000000
-- 
2.7.4
