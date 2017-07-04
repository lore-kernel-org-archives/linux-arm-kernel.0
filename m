From: frank.wang@rock-chips.com (Frank Wang)
Date: Tue,  4 Jul 2017 16:15:01 +0800
Subject: [PATCH 6/6] ARM: dts: rockchip: add gpio power-key for rk3229-evb
In-Reply-To: <1499155967-26090-1-git-send-email-frank.wang@rock-chips.com>
References: <1499155967-26090-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1499156101-26404-1-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds gpio power-key support for rk3229-evb board.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3229-evb.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
index 43c3ad2..7cfe893 100644
--- a/arch/arm/boot/dts/rk3229-evb.dts
+++ b/arch/arm/boot/dts/rk3229-evb.dts
@@ -124,6 +124,24 @@
 			regulator-always-on;
 		};
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
@@ -166,6 +184,12 @@
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
