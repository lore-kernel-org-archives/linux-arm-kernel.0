From: romain.perier@gmail.com (Romain Perier)
Date: Sun, 26 Oct 2014 13:23:46 +0000
Subject: [PATCH v1 1/4] ARM: dts: rockchip: Add devicetree source for
 MarsBoard RK3066
Message-ID: <1414329829-8031-1-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/rk3066a-marsboard.dts | 143 ++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3066a-marsboard.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ca58df9..3c32efe 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -365,6 +365,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8960-cdp.dtb \
 	qcom-msm8974-sony-xperia-honami.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
+	rk3066a-marsboard.dtb \
 	rk3066a-bqcurie2.dtb \
 	rk3188-radxarock.dtb \
 	rk3288-evb-act8846.dtb \
diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts b/arch/arm/boot/dts/rk3066a-marsboard.dts
new file mode 100644
index 0000000..d7d4cd1
--- /dev/null
+++ b/arch/arm/boot/dts/rk3066a-marsboard.dts
@@ -0,0 +1,143 @@
+/*
+ * Copyright (c) 2014 Romain Perier <romain.perier@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+#include "rk3066a.dtsi"
+
+/ {
+	model = "MarsBoard RK3066";
+	compatible = "haoyuelectronics,marsboard-rk3066", "rockchip,rk3066a";
+
+	memory {
+		reg = <0x60000000 0x40000000>;
+	};
+
+	vcc_sd0: fixed-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "sdmmc-supply";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_LOW>;
+		startup-delay-us = <100000>;
+		vin-supply = <&vcc_io>;
+	};
+};
+
+
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	tps: tps at 2d {
+		reg = <0x2d>;
+
+		interrupt-parent = <&gpio6>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+
+		vcc5-supply = <&vcc_io>;
+		vcc6-supply = <&vcc_io>;
+
+		regulators {
+			vcc_rtc: regulator at 0 {
+				regulator-name = "vcc_rtc";
+				regulator-always-on;
+			};
+
+			vcc_io: regulator at 1 {
+				regulator-name = "vcc_io";
+				regulator-always-on;
+			};
+
+			vdd_arm: regulator at 2 {
+				regulator-name = "vdd_arm";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vcc_ddr: regulator at 3 {
+				regulator-name = "vcc_ddr";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vcc18_cif: regulator at 5 {
+				regulator-name = "vcc18_cif";
+				regulator-always-on;
+			};
+
+			vdd_11: regulator at 6 {
+				regulator-name = "vdd_11";
+				regulator-always-on;
+			};
+
+			vcc_25: regulator at 7 {
+				regulator-name = "vcc_25";
+				regulator-always-on;
+			};
+
+			vcc_18: regulator at 8 {
+				regulator-name = "vcc_18";
+				regulator-always-on;
+			};
+
+			vcc25_hdmi: regulator at 9 {
+				regulator-name = "vcc25_hdmi";
+				regulator-always-on;
+			};
+
+			vcca_33: regulator at 10 {
+				regulator-name = "vcca_33";
+				regulator-always-on;
+			};
+
+			vcc_tp: regulator at 11 {
+				regulator-name = "vcc_tp";
+				regulator-always-on;
+			};
+
+			vcc28_cif: regulator at 12 {
+				regulator-name = "vcc28_cif";
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+/* must be included after &tps gets defined */
+#include "tps65910.dtsi"
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
-- 
1.9.1
