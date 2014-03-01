From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  1 Mar 2014 20:26:33 +0100
Subject: [PATCH 14/19] ARM: sun5i: dt: Add USB host nodes to
 a13-olinuxino-micro
In-Reply-To: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
References: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393701998-3553-15-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the usb-phy and ehci- and ohci-usb-host controllers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index fe2ce0a..11169d5 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -14,12 +14,26 @@
 
 /dts-v1/;
 /include/ "sun5i-a13.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Olimex A13-Olinuxino Micro";
 	compatible = "olimex,a13-olinuxino-micro", "allwinner,sun5i-a13";
 
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
 			led_pins_olinuxinom: led_pins at 0 {
 				allwinner,pins = "PG9";
@@ -27,6 +41,13 @@
 				allwinner,drive = <1>;
 				allwinner,pull = <0>;
 			};
+
+			usb1_vbus_pin_olinuxinom: usb1_vbus_pin at 0 {
+				allwinner,pins = "PG11";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		uart1: serial at 01c28400 {
@@ -65,4 +86,10 @@
 			default-state = "on";
 		};
 	};
+
+	reg_usb1_vbus: usb1-vbus {
+		pinctrl-0 = <&usb1_vbus_pin_olinuxinom>;
+		gpio = <&pio 6 11 0>;
+		status = "okay";
+	};
 };
-- 
1.9.0
