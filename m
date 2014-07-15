From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 15 Jul 2014 18:24:34 +0300
Subject: [PATCH 4/6] clk: tegra: add nvidia,tegra132-ccplex-clk binding
In-Reply-To: <1405437890-6468-1-git-send-email-pdeschrijver@nvidia.com>
References: <1405437890-6468-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1405437890-6468-5-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra132 has a few new clocks for the CPU complex (ccplex).

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 .../bindings/clock/nvidia,tegra132-ccplex-clk.txt  |   27 ++++++++++++++++++++
 include/dt-bindings/clock/tegra132-ccplex.h        |   12 +++++++++
 2 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra132-ccplex-clk.txt
 create mode 100644 include/dt-bindings/clock/tegra132-ccplex.h

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra132-ccplex-clk.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra132-ccplex-clk.txt
new file mode 100644
index 0000000..1441e36
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra132-ccplex-clk.txt
@@ -0,0 +1,27 @@
+NVIDIA Tegra132 ccplex clocks
+
+This binding uses the common clock binding:
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+The Tegra132 ccplex clock module on Tegra132 is the HW module responsible
+for the ccplex related clocks.
+
+Required properties :
+- compatible : Should be "nvidia,tegra132-ccplex-clk"
+- reg : Should contain ccplex clock registers location and length
+- #clock-cells : Should be 1.
+  In clock consumers, this cell represents the clock ID exposed by the
+  ccplex clock module. The assignments may be found in header file
+  <dt-bindings/clock/tegra132-ccplex.h>.
+
+Example SoC include file:
+
+/ {
+	ccplex-clock at 0,70040000 {
+		compatible = "nvidia,tegra132-ccplex-clk";
+		reg = <0x0 0x70040000 0x0 0x1000>;
+		status = "okay";
+		#clock-cells = <1>;
+	};
+
+};
diff --git a/include/dt-bindings/clock/tegra132-ccplex.h b/include/dt-bindings/clock/tegra132-ccplex.h
new file mode 100644
index 0000000..58ea190
--- /dev/null
+++ b/include/dt-bindings/clock/tegra132-ccplex.h
@@ -0,0 +1,12 @@
+/*
+ * This header provides constants for the binding nvidia,tegra132-ccplex-clk
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_TEGRA132_CCPLEX_H
+#define __DT_BINDINGS_CLOCK_TEGRA132_CCPLEX_H
+
+#define TEGRA132_CCPLEX_CCLK_G 1
+#define TEGRA132_PLL_X 2
+#define TEGRA132_CCPLEX_CLK_MAX 3
+
+#endif
-- 
1.7.7.rc0.72.g4b5ea.dirty
