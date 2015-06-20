From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 20 Jun 2015 17:40:08 +0200
Subject: [PATCH 2/4] ARM: dts: sun4i: Enable otg controller on the ba10-tvbox
In-Reply-To: <1434814810-26285-1-git-send-email-hdegoede@redhat.com>
References: <1434814810-26285-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1434814810-26285-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ba10-tvbox has the otg controller connected to one of the 2 usb-A
receptacles it has on the front, so enable the otg controller in host-only
mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
index 93d4356..f3cb297 100644
--- a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
+++ b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
@@ -125,12 +125,21 @@
 	status = "okay";
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &pio {
 	usb2_vbus_pin_a: usb2_vbus_pin at 0 {
 		allwinner,pins = "PH12";
 	};
 };
 
+&reg_usb0_vbus {
+	regulator-boot-on;
+	status = "okay";
+};
+
 &reg_usb1_vbus {
 	status = "okay";
 };
@@ -146,7 +155,13 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usbphy {
+	usb0_vbus-supply = <&reg_usb0_vbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	usb2_vbus-supply = <&reg_usb2_vbus>;
 	status = "okay";
-- 
2.4.3
