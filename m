From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 25 Jul 2017 20:45:02 +0800
Subject: [PATCH v2 1/3] arm64: allwinner: a64: enable USB host controller for
 BPi M64
Message-ID: <20170725124504.40242-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Banana Pi M64 connects the USB host-only controller on A64 SoC to a USB
hub, which provided the two USB Type-A ports on the board.

Enable the USB host controller.

The OTG function of the Micro-USB port needs the drivevbus function of
the AXP803 driver implemented, so it's not enabled now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v2:
- Added Chen-Yu's review tag.

 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index ba2fde2909f9..a4a7b9cb59b9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -68,6 +68,10 @@
 	};
 };
 
+&ehci1 {
+	status = "okay";
+};
+
 &emac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
@@ -123,6 +127,10 @@
 	status = "okay";
 };
 
+&ohci1 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
@@ -134,3 +142,7 @@
 	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
 	status = "okay";
 };
+
+&usbphy {
+	status = "okay";
+};
-- 
2.13.0
