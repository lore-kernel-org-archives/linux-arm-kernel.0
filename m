From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 20 Jun 2015 17:40:09 +0200
Subject: [PATCH 3/4] ARM: dts: sun4i: Enable otg controller on the mini-x
In-Reply-To: <1434814810-26285-1-git-send-email-hdegoede@redhat.com>
References: <1434814810-26285-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1434814810-26285-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mini-x has the otg controller connected to one of the 2 usb-A
receptacles it has on the front, so enable the otg controller in host-only
mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
index ebe2a04..a7dd86d 100644
--- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -114,6 +114,15 @@
 	status = "okay";
 };
 
+&otg_sram {
+	status = "okay";
+};
+
+&reg_usb0_vbus {
+	regulator-boot-on;
+	status = "okay";
+};
+
 &reg_usb1_vbus {
 	status = "okay";
 };
@@ -128,7 +137,13 @@
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
