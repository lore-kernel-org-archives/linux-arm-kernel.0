From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  2 May 2014 17:57:28 +0200
Subject: [PATCH v10 14/15] ARM: dts: sun7i: Enable mmc controller on various
 A20 boards
In-Reply-To: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1399046249-19472-15-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cd pin settings have been taken from the original firmware fex files,
and have been confirmed to work on the actual boards.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |  9 +++++++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      |  9 +++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 25 +++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 68de89f..3918e2f 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -20,6 +20,15 @@
 	compatible = "cubietech,cubieboard2", "allwinner,sun7i-a20";
 
 	soc at 01c00000 {
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			bus-width = <4>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-inverted;
+			status = "okay";
+		};
+
 		usbphy: phy at 01c13400 {
 			usb1_vbus-supply = <&reg_usb1_vbus>;
 			usb2_vbus-supply = <&reg_usb2_vbus>;
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index cb25d3c..b2e2efd 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -20,6 +20,15 @@
 	compatible = "cubietech,cubietruck", "allwinner,sun7i-a20";
 
 	soc at 01c00000 {
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			bus-width = <4>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-inverted;
+			status = "okay";
+		};
+
 		usbphy: phy at 01c13400 {
 			usb1_vbus-supply = <&reg_usb1_vbus>;
 			usb2_vbus-supply = <&reg_usb2_vbus>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index eeadf76..1bfef12 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -31,6 +31,24 @@
 			status = "okay";
 		};
 
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			bus-width = <4>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-inverted;
+			status = "okay";
+		};
+
+		mmc3: mmc at 01c12000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc3_pins_a>, <&mmc3_cd_pin_olinuxinom>;
+			bus-width = <4>;
+			cd-gpios = <&pio 7 11 0>; /* PH11 */
+			cd-inverted;
+			status = "okay";
+		};
+
 		usbphy: phy at 01c13400 {
 			usb1_vbus-supply = <&reg_usb1_vbus>;
 			usb2_vbus-supply = <&reg_usb2_vbus>;
@@ -65,6 +83,13 @@
 		};
 
 		pinctrl at 01c20800 {
+			mmc3_cd_pin_olinuxinom: mmc3_cd_pin at 0 {
+				allwinner,pins = "PH11";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+
 			led_pins_olinuxino: led_pins at 0 {
 				allwinner,pins = "PH2";
 				allwinner,function = "gpio_out";
-- 
1.9.0
