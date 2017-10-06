From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  6 Oct 2017 11:36:09 +0100
Subject: [PATCH v7 5/6] dt-bindings: Document devicetree binding for ARM DSU
 PMU
In-Reply-To: <20171006103610.11853-1-suzuki.poulose@arm.com>
References: <20171006103610.11853-1-suzuki.poulose@arm.com>
Message-ID: <20171006103610.11853-6-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents the devicetree bindings for ARM DSU PMU.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: devicetree at vger.kernel.org
Cc: frowand.list at gmail.com
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V3:
 - Fixed node name in the example, suggested by Rob
---
 .../devicetree/bindings/arm/arm-dsu-pmu.txt        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt

diff --git a/Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt b/Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt
new file mode 100644
index 000000000000..6efabba530f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt
@@ -0,0 +1,27 @@
+* ARM DynamIQ Shared Unit (DSU) Performance Monitor Unit (PMU)
+
+ARM DyanmIQ Shared Unit (DSU) integrates one or more CPU cores
+with a shared L3 memory system, control logic and external interfaces to
+form a multicore cluster. The PMU enables to gather various statistics on
+the operations of the DSU. The PMU provides independent 32bit counters that
+can count any of the supported events, along with a 64bit cycle counter.
+The PMU is accessed via CPU system registers and has no MMIO component.
+
+** DSU PMU required properties:
+
+- compatible	: should be one of :
+
+		"arm,dsu-pmu"
+
+- interrupts	: Exactly 1 SPI must be listed.
+
+- cpus		: List of phandles for the CPUs connected to this DSU instance.
+
+
+** Example:
+
+dsu-pmu-0 {
+	compatible = "arm,dsu-pmu";
+	interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>;
+	cpus = <&cpu_0>, <&cpu_1>;
+};
-- 
2.13.6
