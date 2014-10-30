From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Oct 2014 14:53:05 +0900
Subject: [PATCH/RFC] ARM: shmobile: koelsch: Add MSIOF1 support to device tree
Message-ID: <1414648385-29514-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

MSIOF1 pin is selected and device is enabled.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree

 arch/arm/boot/dts/r8a7791-koelsch.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 523ae4d..2ad0e26 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -286,6 +286,12 @@
 		renesas,function = "msiof0";
 	};
 
+	msiof1_pins: spi2 {
+		renesas,groups = "msiof1_clk_c", "msiof1_sync_c", "msiof1_rx_c",
+				 "msiof1_tx_c";
+		renesas,function = "msiof1";
+	};
+
 	usb0_pins: usb0 {
 		renesas,groups = "usb0";
 		renesas,function = "usb0";
@@ -420,6 +426,13 @@
 	};
 };
 
+&msiof1 {
+	pinctrl-0 = <&msiof1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
 	pinctrl-names = "default";
-- 
2.1.1
