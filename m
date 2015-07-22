From: romain.perier@gmail.com (Romain Perier)
Date: Wed, 22 Jul 2015 07:44:05 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: Add veyron-speedy board
Message-ID: <1437543846-19897-1-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Which is formally known as The Asus C201 chromebook

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.txt |  10 +-
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/rk3288-veyron-speedy.dts         | 163 +++++++++++++++++++++
 3 files changed, 174 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-speedy.dts

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 6de18bd2..da02022 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -37,4 +37,12 @@ Rockchip platforms device tree bindings
 - Google Pinky (dev-board):
     Required root node properties:
       - compatible = "google,veyron-pinky-rev2", "google,veyron-pinky",
-		     "google,veyron", "rockchip,rk3288";
\ No newline at end of file
+		     "google,veyron", "rockchip,rk3288";
+
+- Google Speedy (Asus C201 Chromebook):
+    Required root node properties:
+      - compatible = "google,veyron-speedy-rev9", "google,veyron-speedy-rev8",
+		     "google,veyron-speedy-rev7", "google,veyron-speedy-rev6",
+		     "google,veyron-speedy-rev5", "google,veyron-speedy-rev4",
+		     "google,veyron-speedy-rev3", "google,veyron-speedy-rev2",
+		     "google,veyron-speedy", "google,veyron", "rockchip,rk3288";
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 653ede7..bfa7c86 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -498,7 +498,8 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3288-firefly-beta.dtb \
 	rk3288-firefly.dtb \
 	rk3288-veyron-jerry.dtb \
-	rk3288-veyron-pinky.dtb
+	rk3288-veyron-pinky.dtb \
+	rk3288-veyron-speedy.dtb
 dtb-$(CONFIG_ARCH_S3C24XX) += \
 	s3c2416-smdk2416.dtb
 dtb-$(CONFIG_ARCH_S3C64XX) += \
diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
new file mode 100644
index 0000000..6578e2a
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
@@ -0,0 +1,163 @@
+/*
+ * Google Veyron Speedy Rev 1+ board device tree source
+ *
+ * Copyright 2015 Google, Inc
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *  Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "rk3288-veyron-chromebook.dtsi"
+#include "cros-ec-sbs.dtsi"
+
+/ {
+	model = "Google Speedy";
+	compatible = "google,veyron-speedy-rev9", "google,veyron-speedy-rev8",
+		     "google,veyron-speedy-rev7", "google,veyron-speedy-rev6",
+		     "google,veyron-speedy-rev5", "google,veyron-speedy-rev4",
+		     "google,veyron-speedy-rev3", "google,veyron-speedy-rev2",
+		     "google,veyron-speedy", "google,veyron", "rockchip,rk3288";
+
+	panel_regulator: panel-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio7 14 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_enable_h>;
+		regulator-name = "panel_regulator";
+		vin-supply = <&vcc33_sys>;
+	};
+
+	vcc18_lcd: vcc18-lcd {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&avdd_1v8_disp_en>;
+		regulator-name = "vcc18_lcd";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc18_wl>;
+	};
+
+	backlight_regulator: backlight-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 12 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_pwr_en>;
+		regulator-name = "backlight_regulator";
+		vin-supply = <&vcc33_sys>;
+		startup-delay-us = <15000>;
+	};
+};
+
+&rk808 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
+	dvs-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>,
+		    <&gpio7 15 GPIO_ACTIVE_HIGH>;
+};
+
+&sdmmc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_gpio
+			&sdmmc_bus4>;
+	disable-wp;
+};
+
+&vcc_5v {
+	enable-active-high;
+	gpio = <&gpio7 21 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&drv_5v>;
+};
+
+&vcc50_hdmi {
+	enable-active-high;
+	gpio = <&gpio5 19 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&vcc50_hdmi_en>;
+};
+
+&pinctrl {
+	backlight {
+		bl_pwr_en: bl_pwr_en {
+			rockchip,pins = <2 12 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	buck-5v {
+		drv_5v: drv-5v {
+			rockchip,pins = <7 21 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	edp {
+		edp_hpd: edp_hpd {
+			rockchip,pins = <7 11 RK_FUNC_2 &pcfg_pull_down>;
+		};
+	};
+
+	hdmi {
+		vcc50_hdmi_en: vcc50-hdmi-en {
+			rockchip,pins = <5 19 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	lcd {
+		lcd_enable_h: lcd-en {
+			rockchip,pins = <7 14 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		avdd_1v8_disp_en: avdd-1v8-disp-en {
+			rockchip,pins = <2 13 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		dvs_1: dvs-1 {
+			rockchip,pins = <7 12 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		dvs_2: dvs-2 {
+			rockchip,pins = <7 15 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+};
-- 
2.1.4
