From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun,  8 Oct 2017 12:29:06 +0800
Subject: [PATCH 6/6] ARM: sun8i: v40: enable USB host ports for Banana Pi M2
 Berry
In-Reply-To: <20171008042906.46779-1-icenowy@aosc.io>
References: <20171008042906.46779-1-icenowy@aosc.io>
Message-ID: <20171008042906.46779-7-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Banana Pi M2 Berry has an on-board USB Hub that provides 4 USB Type-A
ports, and it's connected to the USB1 port of the SoC.

Enable it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
index fe16fc0eb518..45c17c8c5915 100644
--- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
@@ -87,6 +87,10 @@
 	};
 };
 
+&ehci1 {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -98,6 +102,10 @@
 	};
 };
 
+&ohci1 {
+	status = "okay";
+};
+
 #include "axp22x.dtsi"
 
 &reg_aldo3 {
@@ -171,3 +179,8 @@
 	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
+
+&usbphy {
+	usb1_vbus-supply = <&reg_vcc5v0>;
+	status = "okay";
+};
-- 
2.13.6
