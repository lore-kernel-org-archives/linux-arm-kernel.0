From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 18 Feb 2017 01:37:22 +0800
Subject: [RFC PATCH 9/9] ARM: dts: sun8i: enable USB host for Banana Pi M2
 Ultra
In-Reply-To: <20170217173722.6477-1-icenowy@aosc.xyz>
References: <20170217173722.6477-1-icenowy@aosc.xyz>
Message-ID: <20170217173722.6477-10-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Banana Pi M2 Ultra board features two USB host ports, connected to the
two USB host ports on the SoC.

Add support for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 1d824830a1ad..672fb7f0f393 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -63,6 +63,14 @@
 	};
 };
 
+&ehci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -154,8 +162,23 @@
 	status = "okay";
 };
 
+&ohci1 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_0>;
 	status = "okay";
 };
+
+&usbphy {
+	pinctrl-names = "default";
+	usb1_vbus-supply = <&reg_vcc5v0>;
+	usb2_vbus-supply = <&reg_vcc5v0>;
+	status = "okay";
+};
-- 
2.11.1
