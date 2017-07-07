From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  7 Jul 2017 14:07:47 +0100
Subject: [PATCH 4/5] dt-bindings: Document devicetree binding for ARM DSU PMU
In-Reply-To: <1499432868-18462-1-git-send-email-suzuki.poulose@arm.com>
References: <1499432868-18462-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1499432868-18462-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents the devicetree bindings for ARM DSU PMU.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../devicetree/bindings/arm/arm-dsu-pmu.txt        | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt

diff --git a/Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt b/Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt
new file mode 100644
index 0000000..ca0695d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt
@@ -0,0 +1,28 @@
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
+fcm-pmu at 0 {
+	compatible = "arm,dsu-pmu";
+	interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>;
+	cpus = <&cpu_0>, <&cpu_1>;
+};
+
-- 
2.7.5
