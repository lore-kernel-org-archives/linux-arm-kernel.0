From: l.majewski@samsung.com (Lukasz Majewski)
Date: Thu, 09 Oct 2014 18:38:51 +0200
Subject: [PATCH 15/21] thermal: dts: exynos: Trip points and sensor
 configuration data for Exynos5440
In-Reply-To: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1412872737-624-16-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit provides information about Exynos5440 device configuration.
Previously this information was available in exynos_tmu_data.c file.
Now it is available in the device tree.
Such approach allows reusing some common code for thermal.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi | 25 +++++++++++++++++++++++
 arch/arm/boot/dts/exynos5440-trip-points.dtsi     | 25 +++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5440-trip-points.dtsi

diff --git a/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi b/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
new file mode 100644
index 0000000..336cb12
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
@@ -0,0 +1,25 @@
+/*
+ * Device tree sources for Exynos5440 TMU sensor configuration
+ *
+ * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <dt-bindings/thermal/thermal_exynos.h>
+
+#thermal-sensor-cells = <0>;
+gain = <5>;
+reference_voltage = <16>;
+noise_cancel_mode = <4>;
+efuse_value = <0x5d2d>;
+min_efuse_value = <16>;
+max_efuse_value = <76>;
+first_point_trim = <25>;
+second_point_trim = <70>;
+default_temp_offset = <25>;
+cal_type = <TYPE_ONE_POINT_TRIMMING>;
+type = <SOC_ARCH_EXYNOS5440>;
diff --git a/arch/arm/boot/dts/exynos5440-trip-points.dtsi b/arch/arm/boot/dts/exynos5440-trip-points.dtsi
new file mode 100644
index 0000000..48adfa8
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5440-trip-points.dtsi
@@ -0,0 +1,25 @@
+/*
+ * Device tree sources for default Exynos5440 thermal zone definition
+ *
+ * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+polling-delay-passive = <0>;
+polling-delay = <0>;
+trips {
+	cpu-alert-0 {
+		temperature = <100000>; /* millicelsius */
+		hysteresis = <0>; /* millicelsius */
+		type = "active";
+	};
+	cpu-crit-0 {
+		temperature = <1050000>; /* millicelsius */
+		hysteresis = <0>; /* millicelsius */
+		type = "critical";
+	};
+};
-- 
2.0.0.rc2
