From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 23 Nov 2015 15:36:28 +0100
Subject: [PATCH] ARM: dts: rockchip: Add IR receiver to Radxa Rock 2 Square
Message-ID: <1448289388-25762-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the IR receiver as present on the Radxa Rock 2 Square
board.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 arch/arm/boot/dts/rk3288-rock2-square.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index 0ef065d..1dada8c 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -49,6 +49,13 @@
 		stdout-path = "serial2:115200n8";
 	};
 
+	ir: ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio8 1 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ir_int>;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "SPDIF";
@@ -183,6 +190,12 @@
 };
 
 &pinctrl {
+	ir {
+		ir_int: ir-int {
+			rockchip,pins = <8 1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	pmic {
 		pmic_int: pmic-int {
 			rockchip,pins = <0 4 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.6.2
