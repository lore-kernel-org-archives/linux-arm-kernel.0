From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun,  8 Oct 2017 12:29:05 +0800
Subject: [PATCH 5/6] ARM: sun8i: r40: enable USB host for Banana Pi M2 Ultra
In-Reply-To: <20171008042906.46779-1-icenowy@aosc.io>
References: <20171008042906.46779-1-icenowy@aosc.io>
Message-ID: <20171008042906.46779-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.xyz>

Banana Pi M2 Ultra board features two USB host ports, connected to the
two USB host ports on the SoC.

Add support for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 035599d870b9..8c5efe2a9881 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -93,6 +93,14 @@
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
 
@@ -180,8 +188,22 @@
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
 	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
+
+&usbphy {
+	usb1_vbus-supply = <&reg_vcc5v0>;
+	usb2_vbus-supply = <&reg_vcc5v0>;
+	status = "okay";
+};
-- 
2.13.6
