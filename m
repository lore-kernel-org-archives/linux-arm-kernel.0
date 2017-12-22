From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:29:22 +0100
Subject: [PATCH 11/11] arm64: dts: renesas: salvator-common: enable usb3_peri0
In-Reply-To: <cover.1513936760.git.horms+renesas@verge.net.au>
References: <cover.1513936760.git.horms+renesas@verge.net.au>
Message-ID: <68b2c029e6200933fa3f6c06c8e6de33e8c78c51.1513936761.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch enables usb3_peri0 that uses usb3_phy0 to enable VBUS
detection for the USB3.0 peripheral.

The Salvator-X[S] has USB3.0 type-A connector and supplies VBUS
if USB3.0 host runs. So, you need a special cable for it, and
to stop the VBUS supplies from the board, after you installs
a gadget driver, you should run the following command to avoid
conflict VBUS supply:

	# echo 1 > /sys/kernel/debug/ee020000.usb/b_device

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 38831a734019..a7c1dd1d905a 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -667,6 +667,13 @@
 	status = "okay";
 };
 
+&usb3_peri0 {
+	phys = <&usb3_phy0>;
+	phy-names = "usb";
+
+	status = "okay";
+};
+
 &usb3_phy0 {
 	status = "okay";
 };
-- 
2.11.0
