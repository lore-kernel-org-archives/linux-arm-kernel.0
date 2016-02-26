From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 09:07:46 +0900
Subject: [PATCH 13/14] arm64: dts: salvator-x: enable usb2_phy of channel 1
 and 2
In-Reply-To: <cover.1456445161.git.horms+renesas@verge.net.au>
References: <cover.1456445161.git.horms+renesas@verge.net.au>
Message-ID: <e24250c008f0dbd5ce828898104bc96840dd9b1b.1456445161.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This board has a MAX3355 chip. However, we cannot use the extcon/max3355
driver because the ID pin doesn't connect to a gpio pin (in other words,
it connects to the SoC specific pin).
And, the phy-rcar-gen3-usb2 driver cannot handle such a chip for now.
So, this patch enables usb2_phy of channel 1 and 2.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 1af67579e07a..e415535d2b63 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -188,6 +188,16 @@
 				 "audio_clkout_a", "audio_clkout3_a";
 		renesas,function = "audio_clk";
 	};
+
+	usb1_pins: usb1 {
+		renesas,groups = "usb1";
+		renesas,function = "usb1";
+	};
+
+	usb2_pins: usb2 {
+		renesas,groups = "usb2";
+		renesas,function = "usb2";
+	};
 };
 
 &scif1 {
@@ -348,3 +358,17 @@
 &xhci0 {
 	status = "okay";
 };
+
+&usb2_phy1 {
+	pinctrl-0 = <&usb1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&usb2_phy2 {
+	pinctrl-0 = <&usb2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
2.7.0.rc3.207.g0ac5344
