From: cheat.sc.linux@outlook.com (Maruyama Shohei)
Date: Wed, 18 Jul 2018 14:58:23 +0000
Subject: [PATCH 3/3] arm64: dts: rockchip: add led support for Firefly-RK3399
In-Reply-To: <20180718145727.30217-1-cheat.sc.linux@outlook.com>
References: <20180718145727.30217-1-cheat.sc.linux@outlook.com>
Message-ID: <PS2P216MB0532F58A6ABDA3FD941EF8F2D1530@PS2P216MB0532.KORP216.PROD.OUTLOOK.COM>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shohei Maruyama <cheat.sc.linux@outlook.com>

This commit adds led support for the Firefly-RK3399. The board has two
leds, this commit enables them.

Signed-off-by: Shohei Maruyama <cheat.sc.linux@outlook.com>
---
 .../boot/dts/rockchip/rk3399-firefly.dts      | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index 2fe443511d21..69851757584d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -233,6 +233,26 @@
 		regulator-max-microvolt = <1400000>;
 		vin-supply = <&vcc_sys>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		work-led {
+			label = "work";
+			default-state = "on";
+			gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&work_led_gpio>;
+		};
+
+		diy-led {
+			label = "diy";
+			default-state = "off";
+			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&diy_led_gpio>;
+		};
+	};
 };
 
 &cpu_l0 {
@@ -647,6 +667,16 @@
 			rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	leds {
+		work_led_gpio: work_led-gpio {
+			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		diy_led_gpio: diy_led-gpio {
+			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pwm0 {
-- 
2.18.0
