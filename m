From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 27 Nov 2015 23:53:35 +0100
Subject: [PATCH] ARM: dts: rockchip: add gpio-ir-receiver to the R89 board
Message-ID: <2515484.rcZl3ThkRZ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the IR receiver present on the R89 board.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-r89.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-r89.dts b/arch/arm/boot/dts/rk3288-r89.dts
index 14b9fc7..17f13c7 100644
--- a/arch/arm/boot/dts/rk3288-r89.dts
+++ b/arch/arm/boot/dts/rk3288-r89.dts
@@ -78,6 +78,13 @@
 		};
 	};
 
+	ir: ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ir_int>;
+	};
+
 	vcc_host: vcc-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -310,6 +317,12 @@
 		};
 	};
 
+	ir {
+		ir_int: ir-int {
+			rockchip,pins = <7 0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	pmic {
 		pmic_int: pmic-int {
 			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.6.1
