From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 24 Sep 2014 15:09:19 +0200
Subject: [PATCH v3] ARM: dts: add CPU nodes for Exynos4 SoCs
Message-ID: <5230569.XLlNbB5NvF@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent patch by Tomasz Figa ("irqchip: gic: Fix core ID calculation
when topology is read from DT") fixed GIC driver to filter cluster ID
from values returned by cpu_logical_map() for SoCs having registers
mapped without per-CPU banking making it is possible to add CPU nodes
for Exynos4 SoCs.  In case of Exynos SoCs these CPU nodes are also
required by future changes adding initialization of cpuidle states in
Exynos cpuidle driver through DT.

Tested on Origen board (Exynos4210 SoC) and Trats2 (Exynos4412 SoC).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Based on for-next branch of linux-samsung.git tree.

v3:
- refreshed on top of Kukjin's tree

v2:
- match the unit-address with the reg

 arch/arm/boot/dts/exynos4210.dtsi |   17 +++++++++++++++++
 arch/arm/boot/dts/exynos4212.dtsi |   17 +++++++++++++++++
 arch/arm/boot/dts/exynos4412.dtsi |   29 +++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

Index: b/arch/arm/boot/dts/exynos4210.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos4210.dtsi	2014-09-24 14:38:18.958571829 +0200
+++ b/arch/arm/boot/dts/exynos4210.dtsi	2014-09-24 15:08:14.062510517 +0200
@@ -31,6 +31,23 @@
 		pinctrl2 = &pinctrl_2;
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 900 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x900>;
+		};
+
+		cpu at 901 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x901>;
+		};
+	};
+
 	pmu_system_controller: system-controller at 10020000 {
 		clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
 				"clkout4", "clkout8", "clkout9";
Index: b/arch/arm/boot/dts/exynos4212.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos4212.dtsi	2014-09-24 14:38:18.954571828 +0200
+++ b/arch/arm/boot/dts/exynos4212.dtsi	2014-09-24 14:43:02.198562156 +0200
@@ -22,6 +22,23 @@
 / {
 	compatible = "samsung,exynos4212", "samsung,exynos4";
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at A00 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA00>;
+		};
+
+		cpu at A01 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA01>;
+		};
+	};
+
 	combiner: interrupt-controller at 10440000 {
 		samsung,combiner-nr = <18>;
 	};
Index: b/arch/arm/boot/dts/exynos4412.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos4412.dtsi	2014-09-24 14:38:18.966571830 +0200
+++ b/arch/arm/boot/dts/exynos4412.dtsi	2014-09-24 14:43:02.198562156 +0200
@@ -22,6 +22,35 @@
 / {
 	compatible = "samsung,exynos4412", "samsung,exynos4";
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at A00 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA00>;
+		};
+
+		cpu at A01 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA01>;
+		};
+
+		cpu at A02 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA02>;
+		};
+
+		cpu at A03 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA03>;
+		};
+	};
+
 	combiner: interrupt-controller at 10440000 {
 		samsung,combiner-nr = <20>;
 	};
