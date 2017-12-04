From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  4 Dec 2017 10:40:41 +0100
Subject: [PATCH v2 4/4] arm64: dts: rockchip: enable usb3 nodes on
 rk3328-rock64
In-Reply-To: <20171204094041.25439-1-heiko@sntech.de>
References: <20171204094041.25439-1-heiko@sntech.de>
Message-ID: <20171204094041.25439-4-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the nodes to make the usb3 port usable on that board.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes in v2:
- new patch

 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index d4f80786e7c2..e393c3586c11 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -331,3 +331,12 @@
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
