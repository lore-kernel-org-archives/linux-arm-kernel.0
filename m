From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 25 Jul 2018 19:43:41 +0300
Subject: [PATCH] arm64: dts: renesas: r8a77980: add Cortex-A53 PMU support
In-Reply-To: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
References: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
Message-ID: <d8e355fd-46f5-3798-fe43-811471a75ab6@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the performance monitor unit (PMU) for the Cortex-A53 cores in
the R8A77970 SoC's device tree.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'renesas-devel-20180724-v4.18-rc6' tag of Simon
Horman's 'renesas.git' repo.

 arch/arm64/boot/dts/renesas/r8a77980.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -98,6 +98,15 @@
 		clock-frequency = <0>;
 	};
 
+	pmu_a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts-extended = <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&a53_0>, <&a53_1>, <&a53_2>, <&a53_3>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
