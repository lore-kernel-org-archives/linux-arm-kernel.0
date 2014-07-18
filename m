From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 18 Jul 2014 18:00:02 +0200
Subject: [PATCH] ARM: dts: add CPU nodes for Exynos4 SoCs
Message-ID: <1863399.9O2S91ZvEO@amdc1032>
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
Based on next-20140717 branch of linux-next tree +
- [PATCH 2/6] ARM: EXYNOS: Fix core ID used by platsmp and hotplug code
  http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32811.html
- [PATCH] irqchip: gic: Fix core ID calculation when topology is read from DT
  http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34277.html

 arch/arm/boot/dts/exynos4210.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/exynos4212.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/exynos4412.dtsi | 29 +++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index ee3001f..b99fc83 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -31,6 +31,23 @@
 		pinctrl2 = &pinctrl_2;
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x900>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x901>;
+		};
+	};
+
 	sysram at 02020000 {
 		compatible = "mmio-sram";
 		reg = <0x02020000 0x20000>;
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 3c00e6e..484a2da 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -22,6 +22,23 @@
 / {
 	compatible = "samsung,exynos4212", "samsung,exynos4";
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA00>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA01>;
+		};
+	};
+
 	combiner: interrupt-controller at 10440000 {
 		samsung,combiner-nr = <18>;
 	};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index c42a3e1..89f4743 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -22,6 +22,35 @@
 / {
 	compatible = "samsung,exynos4412", "samsung,exynos4";
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA00>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA01>;
+		};
+
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA02>;
+		};
+
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA03>;
+		};
+	};
+
 	combiner: interrupt-controller at 10440000 {
 		samsung,combiner-nr = <20>;
 	};
-- 
1.8.2.3
