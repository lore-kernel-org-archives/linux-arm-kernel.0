From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  1 Mar 2014 20:26:32 +0100
Subject: [PATCH 13/19] ARM: sun5i: dt: Add USB host nodes to
 a10s-olinuxino-micro
In-Reply-To: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
References: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393701998-3553-14-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the usb-phy and ehci- and ohci-usb-host controllers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 3c9f8b3..23611b7 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 /include/ "sun5i-a10s.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Olimex A10s-Olinuxino Micro";
@@ -34,6 +35,19 @@
 			};
 		};
 
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
 				allwinner,pins = "PE3";
@@ -41,6 +55,13 @@
 				allwinner,drive = <1>;
 				allwinner,pull = <0>;
 			};
+
+			usb1_vbus_pin_olinuxino_m: usb1_vbus_pin at 0 {
+				allwinner,pins = "PB10";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		uart0: serial at 01c28000 {
@@ -98,4 +119,10 @@
 			default-state = "on";
 		};
 	};
+
+	reg_usb1_vbus: usb1-vbus {
+		pinctrl-0 = <&usb1_vbus_pin_olinuxino_m>;
+		gpio = <&pio 1 10 0>;
+		status = "okay";
+	};
 };
-- 
1.9.0
