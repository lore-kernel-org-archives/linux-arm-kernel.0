From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Mar 2016 21:53:21 +0100
Subject: [PATCH 1/2] ARM: dts: sun8i: Fix pio nodes Orangepi Plus dts
Message-ID: <1458680002-15021-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix sun8i-h3-orangepi-plus.dts:
1) Having 2 pio nodes, by merging these into one
2) Having the pio and r_pio nodes before the mmc nodes, while they
   should be sorted by alphabet

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 80 ++++++++++++++--------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index 6273ddf..3d9996f 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -125,47 +125,6 @@
 	status = "okay";
 };
 
-&pio {
-	usb3_vbus_pin_a: usb3_vbus_pin at 0 {
-		allwinner,pins = "PG11";
-		allwinner,function = "gpio_out";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-};
-
-&pio {
-	leds_opc: led_pins at 0 {
-		allwinner,pins = "PA15";
-		allwinner,function = "gpio_out";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-};
-
-&r_pio {
-	leds_r_opc: led_pins at 0 {
-		allwinner,pins = "PL10";
-		allwinner,function = "gpio_out";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-
-	sw_r_opc: key_pins at 0 {
-		allwinner,pins = "PL03";
-		allwinner,function = "gpio_in";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-
-	wifi_pwrseq_pin_orangepi: wifi_pwrseq_pin at 0 {
-		allwinner,pins = "PL7";
-		allwinner,function = "gpio_out";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-};
-
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
@@ -203,6 +162,45 @@
 	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 };
 
+&pio {
+	leds_opc: led_pins at 0 {
+		allwinner,pins = "PA15";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	usb3_vbus_pin_a: usb3_vbus_pin at 0 {
+		allwinner,pins = "PG11";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&r_pio {
+	leds_r_opc: led_pins at 0 {
+		allwinner,pins = "PL10";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	sw_r_opc: key_pins at 0 {
+		allwinner,pins = "PL03";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	wifi_pwrseq_pin_orangepi: wifi_pwrseq_pin at 0 {
+		allwinner,pins = "PL7";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
 &reg_usb1_vbus {
 	gpio = <&pio 6 13 GPIO_ACTIVE_HIGH>;
 	status = "okay";
-- 
2.7.3
