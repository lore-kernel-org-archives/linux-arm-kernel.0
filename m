From: zyw@rock-chips.com (Chris Zhong)
Date: Sat, 10 Oct 2015 17:55:30 +0800
Subject: [PATCH 10/10] ARM: dts: rockchip: add support mipi panel tv080wum-nl0
 for rk3288-evb
In-Reply-To: <1444470930-17150-1-git-send-email-zyw@rock-chips.com>
References: <1444470930-17150-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1444470930-17150-11-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This tv080wum-nl0 panel is a mipi panel, it can use in MIPI_TX socket
of rk3288 evb board.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

 arch/arm/boot/dts/rk3288-evb.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index f6d2e78..d04878f 100644
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
@@ -177,6 +177,21 @@
 	status = "okay";
 };
 
+&mipi_dsi {
+	status = "okay";
+
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
@@ -247,6 +262,9 @@
 		bl_en: bl-en {
 			rockchip,pins = <7 2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+		lcd_en: lcd-en {
+			rockchip,pins = <7 3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	buttons {
-- 
2.6.1
