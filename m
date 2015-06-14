From: linux.amoon@gmail.com (Anand Moon)
Date: Sun, 14 Jun 2015 19:54:04 +0930
Subject: [PATCHv6 3/4] ARM: dts: exynos5422-odroidxu3: Define default
 thermal-zones
In-Reply-To: <1434277445-5243-1-git-send-email-linux.amoon@gmail.com>
References: <1434277445-5243-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1434277445-5243-3-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trip points corresponding to the one defined in the exynos_tmu_data.c
for Exynos5422 have been included so define thermal-zones attribute.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Acked-by: Lukasz Majewski <l.majewski@samsung.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
Changes rebase on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung branch for-next
Changes from v5 : Rename exynos5-cpu-thermal.dtsi to exynos5422-cpu-thermal.dtsi
			as this file belongs to exynos5422 boards
---
 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi | 59 +++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi

diff --git a/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi b/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
new file mode 100644
index 0000000..c73393a
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
@@ -0,0 +1,59 @@
+/*
+ * Device tree sources for Exynos5422 thermal zone
+ *
+ * Copyright (c) 2015 Lukasz Majewski <l.majewski@samsung.com>
+ *			Anand Moon <linux.amoon@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	thermal-zones {
+		cpu0_thermal: cpu0-thermal {
+			thermal-sensors = <&tmu_cpu0 0>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			trips {
+				cpu_alert0: cpu-alert-0 {
+					temperature = <50000>; /* millicelsius */
+					hysteresis = <5000>; /* millicelsius */
+					type = "active";
+				};
+				cpu_alert1: cpu-alert-1 {
+					temperature = <60000>; /* millicelsius */
+					hysteresis = <5000>; /* millicelsius */
+					type = "active";
+				};
+				cpu_alert2: cpu-alert-2 {
+					temperature = <70000>; /* millicelsius */
+					hysteresis = <5000>; /* millicelsius */
+					type = "active";
+				};
+				cpu_crit0: cpu-crit-0 {
+					temperature = <120000>; /* millicelsius */
+					hysteresis = <0>; /* millicelsius */
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+				     trip = <&cpu_alert0>;
+				     cooling-device = <&fan0 0 1>;
+				};
+				map1 {
+				     trip = <&cpu_alert1>;
+				     cooling-device = <&fan0 1 2>;
+				};
+				map2 {
+				     trip = <&cpu_alert2>;
+				     cooling-device = <&fan0 2 3>;
+				};
+			};
+		};
+	};
+};
-- 
2.4.3
