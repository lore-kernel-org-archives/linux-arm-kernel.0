From: katsuhiro@katsuster.net (Katsuhiro Suzuki)
Date: Fri,  7 Sep 2018 00:39:47 +0900
Subject: [PATCH] arm64: dts: rockchip: fix vcc_host1_5v pin assign
Message-ID: <20180906153947.19495-1-katsuhiro@katsuster.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes pin assign of vcc_host1_5v. This regulator is
controlled by USB20_HOST_DRV signal.

ROCK64 schematic says that GPIO0_A2 pin is used as USB20_HOST_DRV.
GPIO0_D3 pin is for SPDIF_TX_M0.

ROCK64 schematic:
http://files.pine64.org/doc/rock64/ROCK64_Schematic_v2.0_20171019.pdf

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 5272e887a434..5852061e497b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -46,7 +46,7 @@
 	vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 RK_PD3 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb20_host_drv>;
 		regulator-name = "vcc_host1_5v";
@@ -238,7 +238,7 @@
 
 	usb2 {
 		usb20_host_drv: usb20-host-drv {
-			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 
-- 
2.18.0
