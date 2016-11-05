From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat,  5 Nov 2016 22:38:30 +0800
Subject: [PATCH 2/2] arm64: dts: sunxi: enable EHCI1,
 OHCI1 and USB PHY nodes in Pine64
In-Reply-To: <20161105143830.10099-1-icenowy@aosc.xyz>
References: <20161105143830.10099-1-icenowy@aosc.xyz>
Message-ID: <20161105143830.10099-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pine64 have two USB Type-A ports, which are wired to the two ports of
A64 USB PHY, and the lower port is the EHCI/OHCI1 port.

Enable the necessary nodes to enable the lower USB port to work.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 4709590..d836995 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -72,3 +72,15 @@
 &i2c1_pins {
 	bias-pull-up;
 };
+
+&usbphy {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
-- 
2.10.1
