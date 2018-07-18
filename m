From: cheat.sc.linux@outlook.com (Maruyama Shohei)
Date: Wed, 18 Jul 2018 14:58:21 +0000
Subject: [PATCH 2/3] arm64: dts: rockchip: add power button support for
 Firefly-RK3399
In-Reply-To: <20180718145727.30217-1-cheat.sc.linux@outlook.com>
References: <20180718145727.30217-1-cheat.sc.linux@outlook.com>
Message-ID: <PS2P216MB0532C24EED873485C60D8367D1530@PS2P216MB0532.KORP216.PROD.OUTLOOK.COM>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shohei Maruyama <cheat.sc.linux@outlook.com>

This commit adds power button support for the Firefly-RK3399.

Signed-off-by: Shohei Maruyama <cheat.sc.linux@outlook.com>
---
 .../boot/dts/rockchip/rk3399-firefly.dts      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index 8ac29824923c..2fe443511d21 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -42,6 +42,7 @@
 
 /dts-v1/;
 #include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/input/linux-event-codes.h>
 #include "rk3399.dtsi"
 #include "rk3399-opp.dtsi"
 
@@ -132,6 +133,25 @@
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwrbtn>;
+
+		button at 0 {
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			label = "GPIO Key Power";
+			linux,input-type = <1>;
+			gpio-key,wakeup = <1>;
+			debounce-interval = <100>;
+		};
+	};
+
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rk808 1>;
-- 
2.18.0
