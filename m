From: william.wu@rock-chips.com (William Wu)
Date: Fri, 16 Jun 2017 18:34:15 +0800
Subject: [PATCH v2 2/2] arm64: dts: rockchip: enable usb2 for RK3328
 evaluation board
In-Reply-To: <1497609255-15724-1-git-send-email-william.wu@rock-chips.com>
References: <1497609255-15724-1-git-send-email-william.wu@rock-chips.com>
Message-ID: <1497609255-15724-3-git-send-email-william.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip's RK3328 evaluation board has one usb2 otg controller
and one usb2 host controller which consist of EHCI and OHCI.
Each usb controller connects with one usb2 phy port through
UTMI+ interface. Let's enable them to support usb2 on RK3328
evaluation board.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
Changes in v2:
- None

 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index cf27239..da02bb7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -55,3 +55,28 @@
 &uart2 {
 	status = "okay";
 };
+
+&u2phy {
+	status = "okay";
+
+	u2phy_otg: otg-port {
+		status = "okay";
+	};
+
+	u2phy_host: host-port {
+		status = "okay";
+	};
+
+};
+
+&usb20_otg {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
-- 
2.0.0
