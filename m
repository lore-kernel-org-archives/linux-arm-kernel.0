From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Fri, 18 Aug 2017 22:48:08 +0800
Subject: [PATCH] arm64: dts: rockchip: Fix wrong rt5514 dmic delay property
 for Gru
Message-ID: <20170818144808.27869-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to rt5514 dt-binding, it should be "realtek,dmic-init-delay-ms".

Fixes: 48f4d9796d99 (arm64: dts: rockchip: add Gru/Kevin DTS)
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

---

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index c489c78b2b5b..5f2e1415b7ab 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -617,7 +617,7 @@ ap_i2c_mic: &i2c1 {
 		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&mic_int>;
-		realtek,dmic-init-delay = <20>;
+		realtek,dmic-init-delay-ms = <20>;
 		wakeup-source;
 	};
 };
-- 
2.11.0
