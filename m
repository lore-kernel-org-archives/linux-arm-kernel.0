From: william.wu@rock-chips.com (William Wu)
Date: Mon, 21 Aug 2017 21:36:06 +0800
Subject: [PATCH v3 3/3] arm64: dts: rockchip: enable usb3 for RK3328
 evaluation board
In-Reply-To: <1503322566-31489-1-git-send-email-william.wu@rock-chips.com>
References: <1503322566-31489-1-git-send-email-william.wu@rock-chips.com>
Message-ID: <1503322566-31489-4-git-send-email-william.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip's RK3328 evaluation board has one USB 3.0 OTG controller,
we enable it and set it act as static xHCI host controller to
support USB 3.0 HOST on RK3328 evaluation board.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
Changes in v3:
- None

Changes in v2:
- None

 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index 86605ae..68e1b424 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -219,3 +219,12 @@
 &usb_host0_ohci {
 	status = "okay";
 };
+
+&usbdrd3 {
+	status = "okay";
+};
+
+&usbdrd_dwc3 {
+	dr_mode = "host";
+	status = "okay";
+};
-- 
2.0.0
