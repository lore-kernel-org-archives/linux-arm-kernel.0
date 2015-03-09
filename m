From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  9 Mar 2015 21:40:27 +0100
Subject: [PATCH 14/15] ARM: dts: sun7i: Enable USB DRC on Cubietruck
In-Reply-To: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1425933628-9672-15-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Byshko <rbyshko@gmail.com>

Enable the otg/drc usb controller on the cubietruck.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 8111b0c..ac8ff33 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -227,6 +227,20 @@
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+		allwinner,pins = "PH19";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+		allwinner,pins = "PH22";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
 
 &pwm {
@@ -288,6 +302,16 @@
 	status = "okay";
 };
 
+&usb_otg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_detect_pin
+		    &usb0_vbus_detect_pin>;
+	dr_mode = "otg";
+	id_det-gpios = <&pio 7 19 GPIO_ACTIVE_HIGH>; /* PH19 */
+	vbus_det-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
+	status = "okay";
+};
+
 &usbphy {
 	usb0_vbus-supply = <&reg_usb0_vbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
-- 
2.3.1
