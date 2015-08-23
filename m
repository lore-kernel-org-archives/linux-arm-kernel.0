From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 24 Aug 2015 00:37:22 +0200
Subject: [PATCH 1/5] ARM: dts: sun4i: inet97fv2: Disable unused usb controllers
Message-ID: <1440369446-22195-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inet97fv2 tablet only has a usb-2 wifi device connected to the second
ehci controller, disable the first ehci controller and both ohci
controllers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index 6c927a8..51621c5 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -61,10 +61,6 @@
 	};
 };
 
-&ehci0 {
-	status = "okay";
-};
-
 &ehci1 {
 	status = "okay";
 };
@@ -94,18 +90,6 @@
 	status = "okay";
 };
 
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
 &reg_usb2_vbus {
 	status = "okay";
 };
@@ -117,7 +101,6 @@
 };
 
 &usbphy {
-	usb1_vbus-supply = <&reg_usb1_vbus>;
 	usb2_vbus-supply = <&reg_usb2_vbus>;
 	status = "okay";
 };
-- 
2.4.3
