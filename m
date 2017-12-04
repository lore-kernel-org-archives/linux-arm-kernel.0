From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  4 Dec 2017 10:40:40 +0100
Subject: [PATCH v2 3/4] arm64: dts: rockchip: enable usb3 for RK3328
 evaluation board
In-Reply-To: <20171204094041.25439-1-heiko@sntech.de>
References: <20171204094041.25439-1-heiko@sntech.de>
Message-ID: <20171204094041.25439-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: William Wu <william.wu@rock-chips.com>

Rockchip's RK3328 evaluation board has one USB 3.0 OTG controller,
we enable it and set it act as static xHCI host controller to
support USB 3.0 HOST on RK3328 evaluation board.

Signed-off-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes in v2:
none

 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index 3d551e3e6c23..95fba84239a7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -306,3 +306,12 @@
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
2.14.2
