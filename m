From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat,  1 Jul 2017 15:16:34 +0100
Subject: [PATCH 2/5] ARM64: dts: marvell: armada37xx: Fix GIC maintenance
 interrupt
In-Reply-To: <20170701141637.24719-1-marc.zyngier@arm.com>
References: <20170701141637.24719-1-marc.zyngier@arm.com>
Message-ID: <20170701141637.24719-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC-500 integrated in the Armada-37xx SoCs is compliant with
the GICv3 architecture, and thus provides a maintenance interrupt
that is required for hypervisors to function correctly.

With the interrupt provided in the DT, KVM now works as it should.
Tested on an Espressobin system.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index dbcc3d4e2ed5..506aee2e796b 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -323,6 +323,7 @@
 				interrupt-controller;
 				reg = <0x1d00000 0x10000>, /* GICD */
 				      <0x1d40000 0x40000>; /* GICR */
+				interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
-- 
2.11.0
