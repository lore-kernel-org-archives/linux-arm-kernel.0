From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon,  8 Feb 2016 03:17:35 +0100
Subject: [PATCH v2 06/10] ARM64: dts: rockchip: Add IR receiver to GeekBox
In-Reply-To: <1454897859-7601-1-git-send-email-afaerber@suse.de>
References: <1454897859-7601-1-git-send-email-afaerber@suse.de>
Message-ID: <1454897859-7601-7-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New
 
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
index e4523a74050f..e84383fd6f10 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
@@ -63,6 +63,13 @@
 		#clock-cells = <0>;
 	};
 
+	ir: ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio3 30 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ir_int>;
+	};
+
 	leds: gpio-leds {
 		compatible = "gpio-leds";
 
@@ -252,6 +259,12 @@
 };
 
 &pinctrl {
+	ir {
+		ir_int: ir-int {
+			rockchip,pins = <3 30 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	pmic {
 		pmic_sleep: pmic-sleep {
 			rockchip,pins = <0 0 RK_FUNC_2 &pcfg_pull_none>;
-- 
2.6.2
