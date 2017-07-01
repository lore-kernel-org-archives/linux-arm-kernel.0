From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat,  1 Jul 2017 15:16:35 +0100
Subject: [PATCH 3/5] ARM64: dts: marvell: armada37xx: Enable memory-mapped GIC
 CPU interface
In-Reply-To: <20170701141637.24719-1-marc.zyngier@arm.com>
References: <20170701141637.24719-1-marc.zyngier@arm.com>
Message-ID: <20170701141637.24719-4-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A53s that power the Armada-37xx SoCs are equipped with
a GIC CPU interface that gets enabled when coupled with a GICv3
interrupt controller, such as the GIC-500 on the this SoC.

Advertise the MMIO ranges provided by the CPUs, which enables
(among other things) GICv2 guests to run under a hypervisor such
as KVM.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 506aee2e796b..2dfc09501f9f 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -322,7 +322,10 @@
 				#interrupt-cells = <3>;
 				interrupt-controller;
 				reg = <0x1d00000 0x10000>, /* GICD */
-				      <0x1d40000 0x40000>; /* GICR */
+				      <0x1d40000 0x40000>, /* GICR */
+				      <0x1d80000 0x2000>,  /* GICC */
+				      <0x1d90000 0x2000>,  /* GICH */
+				      <0x1da0000 0x20000>; /* GICV */
 				interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
-- 
2.11.0
