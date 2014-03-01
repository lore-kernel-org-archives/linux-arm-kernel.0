From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  1 Mar 2014 20:26:31 +0100
Subject: [PATCH 12/19] ARM: sun5i: dt: Add USB host nodes to A13-Olinuxino
In-Reply-To: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
References: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393701998-3553-13-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Byshko <rbyshko@gmail.com>

Add nodes for the usb-phy and ehci- and ohci-usb-host controllers.

Signed-off-by: Roman Byshko <rbyshko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index a4ba5ff..7a9187b 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -13,12 +13,26 @@
 
 /dts-v1/;
 /include/ "sun5i-a13.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Olimex A13-Olinuxino";
 	compatible = "olimex,a13-olinuxino", "allwinner,sun5i-a13";
 
 	soc at 01c00000 {
+		usbphy: phy at 01c13400 {
+			usb1_vbus-supply = <&reg_usb1_vbus>;
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
 		pinctrl at 01c20800 {
 			led_pins_olinuxino: led_pins at 0 {
 				allwinner,pins = "PG9";
@@ -26,6 +40,13 @@
 				allwinner,drive = <1>;
 				allwinner,pull = <0>;
 			};
+
+			usb1_vbus_pin_olinuxino: usb1_vbus_pin at 0 {
+				allwinner,pins = "PG11";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		uart1: serial at 01c28400 {
@@ -63,4 +84,10 @@
 			default-state = "on";
 		};
 	};
+
+	reg_usb1_vbus: usb1-vbus {
+		pinctrl-0 = <&usb1_vbus_pin_olinuxino>;
+		gpio = <&pio 6 11 0>;
+		status = "okay";
+	};
 };
-- 
1.9.0
