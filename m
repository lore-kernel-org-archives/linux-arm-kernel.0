From: j-keerthy@ti.com (Keerthy)
Date: Mon, 8 Feb 2016 14:46:28 +0530
Subject: [PATCH 1/3] arm: dts: DRA7: Add DSPEVE thermal data
In-Reply-To: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
References: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1454922990-7501-2-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes a dtsi file to contain the thermal data
for DSPEVE domain. This data will enable a thermal shutdown at 125C.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi

diff --git a/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi b/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
new file mode 100644
index 0000000..1c39a84
--- /dev/null
+++ b/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
@@ -0,0 +1,27 @@
+/*
+ * Device Tree Source for DRA7x SoC DSPEVE thermal
+ *
+ * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+dspeve_thermal: dspeve_thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+
+			/* sensor       ID */
+	thermal-sensors = <&bandgap     3>;
+
+	trips {
+		dspeve_crit: dspeve_crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
-- 
1.9.1
