From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Fri, 27 Jun 2014 11:11:35 +0300
Subject: [PATCH 2/6] of: Add bindings for nvidia,tegra124-soctherm
In-Reply-To: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1403856699-2140-3-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds binding documentation and headers for the Tegra124
SOCTHERM device tree node.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 .../devicetree/bindings/thermal/tegra-soctherm.txt | 32 ++++++++++++++++++++++
 include/dt-bindings/thermal/tegra124-soctherm.h    | 15 ++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
 create mode 100644 include/dt-bindings/thermal/tegra124-soctherm.h

diff --git a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
new file mode 100644
index 0000000..dc5588e
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
@@ -0,0 +1,32 @@
+Tegra124 SOCTHERM thermal management system
+
+Required properties :
+- compatible : "nvidia,tegra124-soctherm".
+- reg : Should contain 1 entry:
+  - SOCTHERM register set
+- interrupts : Defines the interrupt used by SOCTHERM
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names : Must include the following entries:
+  - tsensor
+  - soctherm
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - soctherm
+- #thermal-sensor-cells : For thermctl sensors. Should be 1.
+
+Example :
+
+	soctherm at 0,700e2000 {
+		compatible = "nvidia,tegra124-soctherm";
+		reg = <0x0 0x700e2000 0x0 0x1000>;
+		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_TSENSOR>,
+			<&tegra_car TEGRA124_CLK_SOC_THERM>;
+		clock-names = "tsensor", "soctherm";
+		resets = <&tegra_car 78>;
+		reset-names = "soctherm";
+
+		#thermal-sensor-cells = <1>;
+	};
diff --git a/include/dt-bindings/thermal/tegra124-soctherm.h b/include/dt-bindings/thermal/tegra124-soctherm.h
new file mode 100644
index 0000000..cbef15d
--- /dev/null
+++ b/include/dt-bindings/thermal/tegra124-soctherm.h
@@ -0,0 +1,15 @@
+/*
+ * This header provides constants for binding nvidia,tegra124-soctherm.
+ */
+
+#ifndef _DT_BINDINGS_THERMAL_TEGRA124_SOCTHERM_H
+#define _DT_BINDINGS_THERMAL_TEGRA124_SOCTHERM_H
+
+#define TEGRA124_SOCTHERM_SENSOR_CPU 0
+#define TEGRA124_SOCTHERM_SENSOR_MEM 1
+#define TEGRA124_SOCTHERM_SENSOR_GPU 2
+#define TEGRA124_SOCTHERM_SENSOR_PLLX 3
+
+#endif
+
+
-- 
1.8.1.5
