From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 24 Aug 2017 17:49:19 +0200
Subject: [PATCH] arm64: dts: rockchip: enable display subsystem on
 rk3399-firefly
Message-ID: <20170824154919.12324-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the graphics-related nodes on the rk3399-firefly which makes
it possible to see output on the on-board hdmi output.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index 7fd4bfcaa38e..05fb773f975b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -255,6 +255,11 @@
 	status = "okay";
 };
 
+&hdmi {
+	ddc-i2c-bus = <&i2c3>;
+	status = "okay";
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	i2c-scl-rising-time-ns = <168>;
@@ -728,3 +733,23 @@
 	status = "okay";
 	dr_mode = "host";
 };
+
+&vopb {
+	assigned-clocks = <&cru ACLK_VOP0>, <&cru HCLK_VOP0>, <&cru DCLK_VOP0>;
+	assigned-clock-rates = <400000000>, <200000000>, <100000000>;
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&vopl {
+	assigned-clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>, <&cru DCLK_VOP1>;
+	assigned-clock-rates = <400000000>, <200000000>, <100000000>;
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};
-- 
2.14.1
