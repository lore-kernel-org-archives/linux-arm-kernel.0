From: ayaka@soulik.info (Randy Li)
Date: Thu,  7 Jul 2016 01:52:44 +0800
Subject: [PATCH 3/3] ARM: dts: add rk3288-firefly-reload
In-Reply-To: <1467827564-28007-1-git-send-email-ayaka@soulik.info>
References: <3015470.z4L7UQJKa9@phil>
 <1467827564-28007-1-git-send-email-ayaka@soulik.info>
Message-ID: <1467827564-28007-4-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The firefly rk3288 reload is a Rockchip rk3288 based develop board.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/rk3288-firefly-reload.dts | 109 ++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 06b6c2d..19a6049 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -606,6 +606,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3288-evb-rk808.dtb \
 	rk3288-firefly-beta.dtb \
 	rk3288-firefly.dtb \
+	rk3288-firefly-reload.dtb \
 	rk3288-miqi.dtb \
 	rk3288-popmetal.dtb \
 	rk3288-r89.dtb \
diff --git a/arch/arm/boot/dts/rk3288-firefly-reload.dts b/arch/arm/boot/dts/rk3288-firefly-reload.dts
new file mode 100644
index 0000000..9805cf2
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-firefly-reload.dts
@@ -0,0 +1,109 @@
+/*
+ * Copyright (c) 2016 Randy Li <ayaka@soulik.info>
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
+ * Or, alternatively,
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
+#include "rk3288-firefly.dtsi"
+
+/ {
+	model = "Firefly-RK3288-reload";
+	compatible = "firefly,firefly-rk3288-reload", "rockchip,rk3288";
+
+};
+
+&leds {
+	power {
+		gpios = <&gpio8 2 GPIO_ACTIVE_LOW>;
+		label = "firefly:blue:power";
+		linux,default-trigger = "default-on";
+		pinctrl-names = "default";
+		pinctrl-0 = <&power_led>;
+	};
+};
+
+&gmac {
+	phy-supply = <&vcc_lan>;
+};
+
+&pinctrl {
+	act8846 {
+		pmic_vsel: pmic-vsel {
+			rockchip,pins = <7 14 RK_FUNC_GPIO &pcfg_output_low>;
+		};
+	};
+
+	ir {
+		ir_int: ir-int {
+			rockchip,pins = <7 0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+};
+
+&pwm1 {
+	status = "disabled";
+};
+
+&io_domains {
+		audio-supply = <&vcca_33>;
+		flash1-supply = <&vcc_lan>;
+};
+
+&regulators {
+	vcca_33: REG7 {
+		regulator-name = "vcca_33";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	vcc_lan: REG8 {
+		regulator-name = "vcc_lan";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	vccio_pmu: REG9 {
+		regulator-name = "vccio_pmu";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
-- 
2.7.4
