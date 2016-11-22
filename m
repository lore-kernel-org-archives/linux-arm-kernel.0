From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 22 Nov 2016 23:58:31 +0800
Subject: [PATCH v2 3/3] arm64: dts: sunxi: enable EHCI1,
 OHCI1 and USB PHY nodes in Pine64
In-Reply-To: <20161122155831.8724-1-icenowy@aosc.xyz>
References: <20161122155831.8724-1-icenowy@aosc.xyz>
Message-ID: <20161122155831.8724-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pine64 have two USB Type-A ports, which are wired to the two ports of
A64 USB PHY, and the lower port is the EHCI/OHCI1 port.

Enable the necessary nodes to enable the lower USB port to work.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes since v1:
- Sort the nodes.
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index c32ebc7..f9a11e6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -57,6 +57,10 @@
 	};
 };
 
+&ehci1 {
+	status = "okay";
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
@@ -67,8 +71,16 @@
 	bias-pull-up;
 };
 
+&ohci1 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
 	status = "okay";
 };
+
+&usbphy {
+	status = "okay";
+};
-- 
2.10.2
