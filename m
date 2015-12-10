From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 10 Dec 2015 13:46:38 +0800
Subject: [PATCH 2/3] ARM: dts: rockchip: add 2 regulators for
 rk3288-evb-act8846
In-Reply-To: <1449726399-12507-1-git-send-email-zyw@rock-chips.com>
References: <1449726399-12507-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1449726399-12507-2-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vcc_wl and vcc_lcd are 2 gpio switches for rk3288-evb-act8846 board.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 arch/arm/boot/dts/rk3288-evb-act8846.dts | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rk3288-evb-act8846.dts
index 53d8b08..7b768b7 100644
--- a/arch/arm/boot/dts/rk3288-evb-act8846.dts
+++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
@@ -43,6 +43,26 @@
 
 / {
 	compatible = "rockchip,rk3288-evb-act8846", "rockchip,rk3288";
+
+	vcc_lcd: vcc-lcd {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio7 3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_en>;
+		regulator-name = "vcc_lcd";
+		vin-supply = <&vcc_io>;
+	};
+
+	vcc_wl: vcc-wl {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio7 9 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_pwr>;
+		regulator-name = "vcc_wl";
+		vin-supply = <&vcc_18>;
+	};
 };
 
 &cpu0 {
@@ -189,3 +209,17 @@
 		};
 	};
 };
+
+&pinctrl {
+	lcd {
+		lcd_en: lcd-en  {
+			rockchip,pins = <7 3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	wifi {
+		wifi_pwr: wifi-pwr {
+			rockchip,pins = <7 9 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
-- 
2.6.3
