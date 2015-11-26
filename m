From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 26 Nov 2015 15:50:25 +0800
Subject: [PATCH v5 11/11] ARM: dts: rockchip: add support mipi panel
 tv080wum-nl0 for rk3288-evb
In-Reply-To: <1448524225-5489-1-git-send-email-zyw@rock-chips.com>
References: <1448524225-5489-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1448524225-5489-12-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This tv080wum-nl0 panel is a mipi panel, it can use in MIPI_TX socket
of rk3288 evb board.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

Changes in v5:
- add a blank line befor lcd_en

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rk3288-evb.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index f6d2e78..2014992 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -47,7 +47,7 @@
 		reg = <0x0 0x80000000>;
 	};
 
-	backlight {
+	backlight: backlight {
 		compatible = "pwm-backlight";
 		brightness-levels = <
 			  0   1   2   3   4   5   6   7
@@ -177,6 +177,20 @@
 	status = "okay";
 };
 
+&mipi_dsi {
+	status = "okay";
+	panel {
+		compatible ="boe,tv080wum-nl0";
+		reg = <0>;
+
+		enable-gpios = <&gpio7 3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_en>;
+		backlight = <&backlight>;
+		status = "okay";
+	};
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
@@ -247,6 +261,10 @@
 		bl_en: bl-en {
 			rockchip,pins = <7 2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+
+		lcd_en: lcd-en {
+			rockchip,pins = <7 3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	buttons {
-- 
2.6.3
