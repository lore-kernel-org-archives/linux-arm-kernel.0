From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 21 Jul 2017 07:07:15 +0800
Subject: [PATCH 1/3] arm64: allwinner: a64: enable USB host controller for BPi
 M64
Message-ID: <20170720230717.58255-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Banana Pi M64 connects the USB host-only controller on A64 SoC to a USB
hub, which provided the two USB Type-A ports on the board.

Enable the USB host controller.

The OTG function of the Micro-USB port needs the drivevbus function of
the AXP803 driver implemented, so it's not enabled now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 0d1f026d831a..829922d077fb 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -67,6 +67,10 @@
 	};
 };
 
+&ehci1 {
+	status = "okay";
+};
+
 &emac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
@@ -122,6 +126,10 @@
 	status = "okay";
 };
 
+&ohci1 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
@@ -133,3 +141,7 @@
 	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
 	status = "okay";
 };
+
+&usbphy {
+	status = "okay";
+};
-- 
2.13.0
