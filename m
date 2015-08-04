From: hdegoede@redhat.com (Hans de Goede)
Date: Tue,  4 Aug 2015 23:30:09 +0200
Subject: [PATCH] ARM: dts: sun4i: Enable otg in host only mode on Jesurun Q5
Message-ID: <1438723809-9010-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Jesurun Q5 has the musb hooked up to an usb-a receptacle, enable it
in host-only mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
index dc2f2ae..7afc7a6 100644
--- a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
+++ b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
@@ -156,6 +156,10 @@
 	status = "okay";
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &pio {
 	emac_power_pin_q5: emac_power_pin at 0 {
 		allwinner,pins = "PH19";
@@ -172,6 +176,11 @@
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
@@ -186,7 +195,13 @@
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
