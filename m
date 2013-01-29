From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Tue, 29 Jan 2013 13:08:53 +0530
Subject: [PATCH V2 5/6] ARM: regulator: add tps6507x device tree data
In-Reply-To: <1359445134-13323-1-git-send-email-manishv.b@ti.com>
References: <1359445134-13323-1-git-send-email-manishv.b@ti.com>
Message-ID: <1359445134-13323-6-git-send-email-manishv.b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree data for tps6507x regulator by adding
all tps6507x regulator nodes. Regulators are initialized
based on compatible name provided in tps6507x DT file.

All tps6507x PMIC regulator device tree nodes are placed
in a separate device tree include file (tps6507x.dtsi).
tps6507x.dtsi file is created using datasheet
http://www.ti.com/lit/ds/symlink/tps65070.pdf

Tested on da850-evm.

Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
---
Changes since V1:
 - Updated Copyright information.

:000000 100644 0000000... 4c326e5... A	arch/arm/boot/dts/tps6507x.dtsi
 arch/arm/boot/dts/tps6507x.dtsi |   47 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tps6507x.dtsi b/arch/arm/boot/dts/tps6507x.dtsi
new file mode 100644
index 0000000..4c326e5
--- /dev/null
+++ b/arch/arm/boot/dts/tps6507x.dtsi
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Integrated Power Management Chip
+ * http://www.ti.com/lit/ds/symlink/tps65070.pdf
+ */
+
+&tps {
+	compatible = "ti,tps6507x";
+
+	regulators {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdcdc1_reg: regulator at 0 {
+			reg = <0>;
+			regulator-compatible = "VDCDC1";
+		};
+
+		vdcdc2_reg: regulator at 1 {
+			reg = <1>;
+			regulator-compatible = "VDCDC2";
+		};
+
+		vdcdc3_reg: regulator at 2 {
+			reg = <2>;
+			regulator-compatible = "VDCDC3";
+		};
+
+		ldo1_reg: regulator at 3 {
+			reg = <3>;
+			regulator-compatible = "LDO1";
+		};
+
+		ldo2_reg: regulator at 4 {
+			reg = <4>;
+			regulator-compatible = "LDO2";
+		};
+
+	};
+};
-- 
1.7.4.1
