From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 16 Mar 2017 00:21:51 +0800
Subject: [PATCH 4/4] ARM: sun8i: v3s: add ns2009 node for Lichee Pi Zero board
Message-ID: <20170315162151.54956-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The production batch of Lichee Pi Zero board features a NS2009 resistive
touchscreen controller, which is wired to touch panel pins at 40-pin LCD
connector, in order to make the board fully compatible to 40-pin LCDs
with resistive touch panel which are used with Lichee Pi One (with A13's
integrated resistive touch controller).

Add the device node for the touchscreen controller.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
index 387fc2aa546d..a8a2081175d3 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
@@ -86,6 +86,15 @@
 	status = "okay";
 };
 
+&i2c0 {
+	status = "okay";
+
+	ns2009: ns2009 at 48 {
+		compatible = "nsiway,ns2009";
+		reg = <0x48>;
+	};
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_pins_a>;
 	pinctrl-names = "default";
-- 
2.12.0
