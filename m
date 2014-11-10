From: rbyshko@gmail.com (Roman Byshko)
Date: Mon, 10 Nov 2014 19:55:07 +0100
Subject: [PATCH v2 2/5] ARM: dtsi: sunxi: add common VBUS regulator
In-Reply-To: <cover.1415645258.git.rbyshko@gmail.com>
References: <cover.1415645258.git.rbyshko@gmail.com>
Message-ID: <d6e966ae198fa018e0f13a7cbd3e8593641f7e80.1415645258.git.rbyshko@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now the regulator nodes for powering USB VBUS
existed only for the two host controllers. Now the regulator
is added for USB OTG too.

Signed-off-by: Roman Byshko <rbyshko@gmail.com>
---
 arch/arm/boot/dts/sunxi-common-regulators.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
index c9c5b10..f521672 100644
--- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -21,6 +21,13 @@
 				allwinner,pull = <0>;
 			};
 
+			usb0_vbus_pin_a: usb0_vbus_pin at 0 {
+				allwinner,pins = "PB9";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			usb1_vbus_pin_a: usb1_vbus_pin at 0 {
 				allwinner,pins = "PH6";
 				allwinner,function = "gpio_out";
@@ -49,6 +56,18 @@
 		status = "disabled";
 	};
 
+	reg_usb0_vbus: usb0-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb0_vbus_pin_a>;
+		regulator-name = "usb0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&pio 1 9 0>;
+		status = "disabled";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-- 
2.1.2
