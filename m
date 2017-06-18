From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Sun, 18 Jun 2017 09:58:55 +0800
Subject: [PATCH V1 9/9] arm64: dts: add ccu for SC9860
In-Reply-To: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170618015855.27738-10-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we have clock driver, so add clock dt for SC9860 platform.
This patch also removed "ext-26m" from whale2.dtsi since it
is described in sc9860-ccu.dtsi.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 arch/arm64/boot/dts/sprd/sc9860-ccu.dtsi | 67 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/sprd/sc9860.dtsi     |  2 +
 arch/arm64/boot/dts/sprd/whale2.dtsi     |  8 ----
 3 files changed, 69 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/sprd/sc9860-ccu.dtsi

diff --git a/arch/arm64/boot/dts/sprd/sc9860-ccu.dtsi b/arch/arm64/boot/dts/sprd/sc9860-ccu.dtsi
new file mode 100644
index 0000000..e15bf2d
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/sc9860-ccu.dtsi
@@ -0,0 +1,67 @@
+/*
+ * Spreadtrum SC9860 SoC CCU
+ *
+ * Copyright (C) 2017, Spreadtrum Communications Inc.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+&soc {
+	ext_26m: ext-26m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "ext-26m";
+	};
+
+	ext_32m_sine0: ext-32m-sine0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32000000>;
+		clock-output-names = "ext-32m-sine0";
+	};
+
+	ext_32m_sine1: ext-32m-sine1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32000000>;
+		clock-output-names = "ext-32m-sine1";
+	};
+
+	ext_rco_100m: ext-rco-100m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "ext-rco-100m";
+	};
+
+	ext_32k: ext-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "ext-32k";
+	};
+
+	ccu: clk {
+		compatible = "sprd,sc9860-ccu";
+		#clock-cells = <1>;
+		reg = <0 0x20000000 0 0x400>,
+		      <0 0x20210000 0 0x3000>,
+		      <0 0x402b0000 0 0x4000>,
+		      <0 0x402d0000 0 0x400>,
+		      <0 0x402e0000 0 0x4000>,
+		      <0 0x40400000 0 0x400>,
+		      <0 0x40880000 0 0x400>,
+		      <0 0x415e0000 0 0x400>,
+		      <0 0x60200000 0 0x400>,
+		      <0 0x61000000 0 0x400>,
+		      <0 0x61100000 0 0x3000>,
+		      <0 0x62000000 0 0x4000>,
+		      <0 0x62100000 0 0x4000>,
+		      <0 0x63000000 0 0x400>,
+		      <0 0x63100000 0 0x3000>,
+		      <0 0x70b00000 0 0x3000>;
+		clocks = <&ext_26m>, <&ext_rco_100m>, <&ext_32k>;
+		clock-names = "ext-26m", "ext-rco-100m", "ext-32k";
+	};
+};
diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index 7b7d8ce..10ff7c6 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -7,7 +7,9 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/sc9860-ccu.h>
 #include "whale2.dtsi"
+#include "sc9860-ccu.dtsi"
 
 / {
 	cpus {
diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 7c217c5..9d69b84 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -59,13 +59,5 @@
 				status = "disabled";
 			};
 		};
-
-	};
-
-	ext_26m: ext-26m {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <26000000>;
-		clock-output-names = "ext_26m";
 	};
 };
-- 
2.7.4
