From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon,  8 Feb 2016 03:17:36 +0100
Subject: [PATCH v2 07/10] ARM64: dts: rockchip: Add power key to GeekBox
In-Reply-To: <1454897859-7601-1-git-send-email-afaerber@suse.de>
References: <1454897859-7601-1-git-send-email-afaerber@suse.de>
Message-ID: <1454897859-7601-8-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New
 
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
index e84383fd6f10..fe5aa785cfda 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
@@ -70,6 +70,22 @@
 		pinctrl-0 = <&ir_int>;
 	};
 
+	keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwr_key>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		button at 0 {
+			reg = <0>;
+			gpio-key,wakeup = <1>;
+			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
+			label = "GPIO Power";
+			linux,code = <116>;
+		};
+	};
+
 	leds: gpio-leds {
 		compatible = "gpio-leds";
 
@@ -265,6 +281,12 @@
 		};
 	};
 
+	keys {
+		pwr_key: pwr-key {
+			rockchip,pins = <0 2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	pmic {
 		pmic_sleep: pmic-sleep {
 			rockchip,pins = <0 0 RK_FUNC_2 &pcfg_pull_none>;
-- 
2.6.2
