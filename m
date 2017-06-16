From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Fri, 16 Jun 2017 14:28:23 +0300
Subject: [PATCH 2/4] dt-bindings: Add bindings for nvidia,
 tegra186-bpmp-thermal
In-Reply-To: <20170616112825.31025-1-mperttunen@nvidia.com>
References: <20170616112825.31025-1-mperttunen@nvidia.com>
Message-ID: <20170616112825.31025-2-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Tegra186, the BPMP (Boot and Power Management Processor) implements
an interface that is used to read system temperatures, including CPU
cluster and GPU temperatures. This binding describes the thermal sensor
that is exposed by BPMP.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 .../thermal/nvidia,tegra186-bpmp-thermal.txt       | 32 ++++++++++++++++++++++
 .../dt-bindings/thermal/tegra186-bpmp-thermal.h    | 14 ++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
 create mode 100644 include/dt-bindings/thermal/tegra186-bpmp-thermal.h

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
new file mode 100644
index 000000000000..276387dd6815
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
@@ -0,0 +1,32 @@
+NVIDIA Tegra186 BPMP thermal sensor
+
+In Tegra186, the BPMP (Boot and Power Management Processor) implements an
+interface that is used to read system temperatures, including CPU cluster
+and GPU temperatures. This binding describes the thermal sensor that is
+exposed by BPMP.
+
+The BPMP thermal node must be located directly inside the main BPMP node. See
+../firmware/nvidia,tegra186-bpmp.txt for details of the BPMP binding.
+
+This node represents a thermal sensor. See thermal.txt for details of the
+core thermal binding.
+
+Required properties:
+- compatible:
+    Array of strings.
+    One of:
+    - "nvidia,tegra186-bpmp-thermal".
+- #thermal-sensor-cells: Cell for sensor index.
+    Single-cell integer.
+    Must be <1>.
+
+Example:
+
+bpmp {
+	...
+
+	bpmp_thermal: thermal {
+		compatible = "nvidia,tegra186-bpmp-thermal";
+		#thermal-sensor-cells = <1>;
+	};
+};
diff --git a/include/dt-bindings/thermal/tegra186-bpmp-thermal.h b/include/dt-bindings/thermal/tegra186-bpmp-thermal.h
new file mode 100644
index 000000000000..a96b8fa31aab
--- /dev/null
+++ b/include/dt-bindings/thermal/tegra186-bpmp-thermal.h
@@ -0,0 +1,14 @@
+/*
+ * This header provides constants for binding nvidia,tegra186-bpmp-thermal.
+ */
+
+#ifndef _DT_BINDINGS_THERMAL_TEGRA186_BPMP_THERMAL_H
+#define _DT_BINDINGS_THERMAL_TEGRA186_BPMP_THERMAL_H
+
+#define TEGRA186_BPMP_THERMAL_ZONE_CPU 2
+#define TEGRA186_BPMP_THERMAL_ZONE_GPU 3
+#define TEGRA186_BPMP_THERMAL_ZONE_AUX 4
+#define TEGRA186_BPMP_THERMAL_ZONE_PLLX 5
+#define TEGRA186_BPMP_THERMAL_ZONE_AO 6
+
+#endif
-- 
2.13.1
