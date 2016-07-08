From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  8 Jul 2016 18:05:53 +0200
Subject: [PATCH 12/15] ARM: dts: sun8i: Use sun8i-reference-design-tablet for
 ga10h dts
In-Reply-To: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
References: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467993956-19535-13-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This results in quite a nice cleanup for this dts file.

As an added bonus this also enables backlight, regulator and full otg
support. I've tested that all these works as advertised.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts | 77 +-----------------------------
 1 file changed, 1 insertion(+), 76 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
index 1aefc67..6566032 100644
--- a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
+++ b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
@@ -42,59 +42,18 @@
 
 /dts-v1/;
 #include "sun8i-a33.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
+#include "sun8i-reference-design-tablet.dtsi"
 
 / {
 	model = "Allwinner GA10H Quad Core Tablet (v1.1)";
 	compatible = "allwinner,ga10h-v1.1", "allwinner,sun8i-a33";
-
-	aliases {
-		serial0 = &r_uart;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
 };
 
 &ehci0 {
 	status = "okay";
 };
 
-&i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
-	status = "okay";
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
-	status = "okay";
-};
-
 &lradc {
-	vref-supply = <&reg_vcc3v0>;
-	status = "okay";
-
-	button at 200 {
-		label = "Volume Up";
-		linux,code = <KEY_VOLUMEUP>;
-		channel = <0>;
-		voltage = <200000>;
-	};
-
-	button at 400 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <400000>;
-	};
-
 	button at 600 {
 		label = "Back";
 		linux,code = <KEY_BACK>;
@@ -103,40 +62,6 @@
 	};
 };
 
-&mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_q8h>;
-	vmmc-supply = <&reg_vcc3v0>;
-	bus-width = <4>;
-	cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
-	cd-inverted;
-	status = "okay";
-};
-
 &ohci0 {
 	status = "okay";
 };
-
-&pio {
-	mmc0_cd_pin_q8h: mmc0_cd_pin at 0 {
-		allwinner,pins = "PB4";
-		allwinner,function = "gpio_in";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-	};
-};
-
-&r_uart {
-	pinctrl-names = "default";
-	pinctrl-0 = <&r_uart_pins_a>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usbphy {
-	status = "okay";
-};
-- 
2.7.4
