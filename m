From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat,  1 Jul 2017 15:16:36 +0100
Subject: [PATCH 4/5] ARM64: dts: marvell: armada37xx: Wire PMUv3
In-Reply-To: <20170701141637.24719-1-marc.zyngier@arm.com>
References: <20170701141637.24719-1-marc.zyngier@arm.com>
Message-ID: <20170701141637.24719-5-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A53s that power the Armada-37xx SoCs are equipped with
a PMUv3, just like most ARMv8 cores.

Advertise the PMUv3 presence in the device tree, and wire its
interrupt. This allows the perf subsystem to work correctly.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 2dfc09501f9f..d6a060d9f083 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -81,6 +81,11 @@
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	pmu {
+                compatible = "arm,armv8-pmuv3";
+                interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.11.0
