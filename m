From: frank.wang@rock-chips.com (Frank Wang)
Date: Wed,  5 Jul 2017 16:33:10 +0800
Subject: [PATCH v2 6/6] ARM: dts: rockchip: add gpio power-key for rk3229-evb
In-Reply-To: <1499243421-21460-1-git-send-email-frank.wang@rock-chips.com>
References: <1499243421-21460-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1499243590-21772-1-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds gpio power-key support for rk3229-evb board.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3229-evb.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
index cfcfe2a..a051708 100644
--- a/arch/arm/boot/dts/rk3229-evb.dts
+++ b/arch/arm/boot/dts/rk3229-evb.dts
@@ -139,6 +139,24 @@
 		regulator-boot-on;
 		pwm-supply = <&vcc_sys>;
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwr_key>;
+
+		power_key: power-key {
+			label = "GPIO Key Power";
+			gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
+			linux,code = <116>;
+			debounce-interval = <100>;
+			wakeup-source;
+		};
+	};
 };
 
 &cpu0 {
@@ -177,6 +195,12 @@
 };
 
 &pinctrl {
+	keys {
+		pwr_key: pwr-key {
+			rockchip,pins = <3 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	usb {
 		host_vbus_drv: host-vbus-drv {
 			rockchip,pins = <3 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.0.0
