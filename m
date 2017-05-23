From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 23 May 2017 11:54:27 +0200
Subject: [PATCH 3/3] arm64: dts: rockchip: enable usb3 controllers on
 rk3399-firefly
In-Reply-To: <20170523095427.7421-1-heiko@sntech.de>
References: <20170523095427.7421-1-heiko@sntech.de>
Message-ID: <20170523095427.7421-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows basic usage of usb3 devices but no typec specific things yet.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index ef47360ad286..ba1d9810ad1e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -698,3 +698,21 @@
 &usb_host1_ohci {
 	status = "okay";
 };
+
+&usbdrd3_0 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_0 {
+	status = "okay";
+	dr_mode = "otg";
+};
+
+&usbdrd3_1 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_1 {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.11.0
