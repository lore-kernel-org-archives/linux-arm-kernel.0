From: john@metanate.com (John Keeping)
Date: Sun, 18 Feb 2018 17:03:34 +0000
Subject: [PATCH 1/3] ARM: dts: rockchip: add power key for Rock2 Square
Message-ID: <20180218170336.31819-1-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the power button on Radxa Rock2 Square.

Signed-off-by: John Keeping <john@metanate.com>
---
 arch/arm/boot/dts/rk3288-rock2-square.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index 0e084b8a86ac..6adeb331452f 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -39,6 +39,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
 #include "rk3288-rock2-som.dtsi"
 
 / {
@@ -49,6 +50,19 @@
 		stdout-path = "serial2:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
+			label = "GPIO Power";
+			linux,code = <KEY_POWER>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwr_key>;
+			wakeup-source;
+		};
+	};
+
 	gpio-leds {
 		compatible = "gpio-leds";
 
@@ -220,6 +234,12 @@
 		};
 	};
 
+	keys {
+		pwr_key: pwr-key {
+			rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	pmic {
 		pmic_int: pmic-int {
 			rockchip,pins = <0 4 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.16.1
