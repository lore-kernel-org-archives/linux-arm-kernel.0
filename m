From: rbyshko@gmail.com (Roman Byshko)
Date: Mon, 27 Oct 2014 22:43:04 +0100
Subject: [PATCH 4/5] ARM: dts: sun7i: Cubietruck: override regulator pin
In-Reply-To: <cover.1414444953.git.rbyshko@gmail.com>
References: <cover.1414444953.git.rbyshko@gmail.com>
Message-ID: <43a07cc5db10fbd0465cdea43e00a92424be1fda.1414444953.git.rbyshko@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cubietruck uses different pin for the USB OTG VBUS that
is why we override the one defined in sunxi-common-regulators.dtsi
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index a6c1a3c..1682307 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -92,6 +92,13 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			usb0_vbus_pin_a: usb0_vbus_pin at 0 {
+				allwinner,pins = "PH17";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		pwm: pwm at 01c20e00 {
@@ -185,6 +192,12 @@
 		status = "okay";
 	};
 
+	reg_usb0_vbus: usb0-vbus {
+		pinctrl-0 = <&usb0_vbus_pin_a>;
+		gpio = <&pio 7 17 0>;
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		status = "okay";
 	};
-- 
2.1.2
