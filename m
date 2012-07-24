From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 24 Jul 2012 11:48:53 +0530
Subject: [PATCH v2 2/4] ARM: OMAP2+: AM33XX: Add tps65217 device tree data
In-Reply-To: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
Message-ID: <1343110735-10640-3-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree data for tps65217 regulator by adding all tps65217
regulator nodes. Regulator is initialized based on compatible name
provided in tps65217 DT file.

All tps65217 PMIC regulator device tree nodes are placed in a
separate device tree include file (tps65217.dtsi). This patch
was tested on AM335x-Bone.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/tps65217.dtsi |   56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 arch/arm/boot/dts/tps65217.dtsi

diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
new file mode 100644
index 0000000..a632724
--- /dev/null
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -0,0 +1,56 @@
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
+		};
+
+		dcdc2_reg: regulator at 1 {
+			reg = <1>;
+			regulator-compatible = "dcdc2";
+		};
+
+		dcdc3_reg: regulator at 2 {
+			reg = <2>;
+			regulator-compatible = "dcdc3";
+		};
+
+		ldo1_reg: regulator at 3 {
+			reg = <3>;
+			regulator-compatible = "ldo1";
+		};
+
+		ldo2_reg: regulator at 4 {
+			reg = <4>;
+			regulator-compatible = "ldo2";
+		};
+
+		ldo3_reg: regulator at 5 {
+			reg = <5>;
+			regulator-compatible = "ldo3";
+		};
+
+		ldo4_reg: regulator at 6 {
+			reg = <6>;
+			regulator-compatible = "ldo4";
+		};
+	};
+};
-- 
1.7.9.5
