From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 14 Jun 2018 13:30:37 +0200
Subject: [PATCH 2/4] arm64: dts: rockchip: add phandles to some nodes on
 rk3399-gru
In-Reply-To: <20180614113039.29117-1-heiko@sntech.de>
References: <20180614113039.29117-1-heiko@sntech.de>
Message-ID: <20180614113039.29117-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some nodes will need to be refined on a per board level, so add phandles
to them to reference them later.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 614b4f198cc0..ca07f6032200 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -267,7 +267,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&bt_host_wake_l>;
 
-		wake-on-bt {
+		wake_on_bt: wake-on-bt {
 			label = "Wake-on-Bluetooth";
 			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_WAKEUP>;
@@ -285,7 +285,7 @@
 		status = "okay";
 	};
 
-	sound {
+	sound: sound {
 		compatible = "rockchip,rk3399-gru-sound";
 		rockchip,cpu = <&i2s0 &i2s2>;
 	};
@@ -813,7 +813,7 @@ ap_i2c_audio: &i2c8 {
 		};
 	};
 
-	wifi {
+	wifi: wifi {
 		wlan_module_reset_l: wlan-module-reset-l {
 			rockchip,pins = <1 11 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
-- 
2.17.0
