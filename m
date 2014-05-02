From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  2 May 2014 17:57:20 +0200
Subject: [PATCH v10 06/15] ARM: dts: sun4i: Enable mmc controller on various
 A10 boards
In-Reply-To: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1399046249-19472-7-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested on a subset of these boards, for the others boards the settings match
the ones of the tested boards according to the original firmware fex files.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts          | 9 +++++++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts     | 9 +++++++++
 arch/arm/boot/dts/sun4i-a10-hackberry.dts      | 9 +++++++++
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts      | 9 +++++++++
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts     | 9 +++++++++
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 9 +++++++++
 arch/arm/boot/dts/sun4i-a10-pcduino.dts        | 9 +++++++++
 7 files changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index fa746aea..93af306 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -36,6 +36,15 @@
 			};
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
 		usbphy: phy at 01c13400 {
 			usb1_vbus-supply = <&reg_usb1_vbus>;
 			usb2_vbus-supply = <&reg_usb2_vbus>;
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 4684cbe..8581385 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -34,6 +34,15 @@
 			};
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
 		usbphy: phy at 01c13400 {
 			usb1_vbus-supply = <&reg_usb1_vbus>;
 			usb2_vbus-supply = <&reg_usb2_vbus>;
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index d7c17e4..9dc7b1c 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -36,6 +36,15 @@
 			};
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
 		usbphy: phy at 01c13400 {
 			usb1_vbus-supply = <&reg_usb1_vbus>;
 			usb2_vbus-supply = <&reg_usb2_vbus>;
diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index fe9272e..297b8f6 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -24,6 +24,15 @@
 	};
 
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
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
index dd84a9e..b7a4218 100644
--- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -20,6 +20,15 @@
 	compatible = "pineriver,mini-xplus", "allwinner,sun4i-a10";
 
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
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 66cf0c7..4b7fd04 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -33,6 +33,15 @@
 			};
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
 		usbphy: phy at 01c13400 {
 			usb1_vbus-supply = <&reg_usb1_vbus>;
 			usb2_vbus-supply = <&reg_usb2_vbus>;
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index 255b47e..4d9c3cd 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -34,6 +34,15 @@
 			};
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
 		usbphy: phy at 01c13400 {
 			usb1_vbus-supply = <&reg_usb1_vbus>;
 			usb2_vbus-supply = <&reg_usb2_vbus>;
-- 
1.9.0
