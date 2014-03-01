From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  1 Mar 2014 20:26:35 +0100
Subject: [PATCH 16/19] ARM: sun7i: dt: Add USB host nodes to cubieboard2 dts
In-Reply-To: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
References: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393701998-3553-17-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Byshko <rbyshko@gmail.com>

Add nodes for the usb-phy and ehci- and ohci-usb-host controllers.

Signed-off-by: Roman Byshko <rbyshko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 4bed115..68de89f 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -20,11 +20,33 @@
 	compatible = "cubietech,cubieboard2", "allwinner,sun7i-a20";
 
 	soc at 01c00000 {
+		usbphy: phy at 01c13400 {
+			usb1_vbus-supply = <&reg_usb1_vbus>;
+			usb2_vbus-supply = <&reg_usb2_vbus>;
+			status = "okay";
+		};
+
+		ehci0: usb at 01c14000 {
+			status = "okay";
+		};
+
+		ohci0: usb at 01c14400 {
+			status = "okay";
+		};
+
 		ahci: sata at 01c18000 {
 			target-supply = <&reg_ahci_5v>;
 			status = "okay";
 		};
 
+		ehci1: usb at 01c1c000 {
+			status = "okay";
+		};
+
+		ohci1: usb at 01c1c400 {
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			led_pins_cubieboard2: led_pins at 0 {
 				allwinner,pins = "PH20", "PH21";
@@ -84,4 +106,12 @@
 	reg_ahci_5v: ahci-5v {
 		status = "okay";
 	};
+
+	reg_usb1_vbus: usb1-vbus {
+		status = "okay";
+	};
+
+	reg_usb2_vbus: usb2-vbus {
+		status = "okay";
+	};
 };
-- 
1.9.0
