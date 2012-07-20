From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 20 Jul 2012 12:16:27 +0530
Subject: [PATCH RESEND 2/4] ARM: OMAP2+: AM33XX: Add tps65217 device tree data
In-Reply-To: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
Message-ID: <1342766789-28148-3-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree data for tps65217 regulator by adding all the consumers
necessary for AM335X-BeagleBone. The data will be map to a regulator
constraints which is required for regulator set_voltage and get_voltage
calls.

All tps65217 PMIC regulator constraints are placed in a seperate device
tree include file (tps65217.dtsi).

This patch is tested by adding the I2C slave address of TPS65217
pmic to am335x-bone.dts file (Not included in this, I2C slave
addition patch will be submitted to linux-omap, where am335x-bone.dts
binding file is available).

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/tps65217.dtsi |   84 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/tps65217.dtsi

diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
new file mode 100644
index 0000000..cbb9e5d
--- /dev/null
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Integrated Power Management Chip
+ * http://www.ti.com/lit/ds/symlink/tps65217.pdf
+ */
+
+&tps {
+	compatible = "ti,tps65217";
+
+	regulators {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dcdc1_reg: regulator at 0 {
+			reg = <0>;
+			regulator-compatible = "dcdc1";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		dcdc2_reg: regulator at 1 {
+			reg = <1>;
+			regulator-compatible = "dcdc2";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		dcdc3_reg: regulator at 2 {
+			reg = <2>;
+			regulator-compatible = "dcdc3";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1500000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		ldo1_reg: regulator at 3 {
+			reg = <3>;
+			regulator-compatible = "ldo1";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		ldo2_reg: regulator at 4 {
+			reg = <4>;
+			regulator-compatible = "ldo2";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		ldo3_reg: regulator at 5 {
+			reg = <5>;
+			regulator-compatible = "ldo3";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		ldo4_reg: regulator at 6 {
+			reg = <6>;
+			regulator-compatible = "ldo4";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+	};
+};
-- 
1.7.0.4
