From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat,  1 Jul 2017 15:16:33 +0100
Subject: [PATCH 1/5] ARM64: dts: marvell: armada37xx: Fix timer interrupt
 specifiers
In-Reply-To: <20170701141637.24719-1-marc.zyngier@arm.com>
References: <20170701141637.24719-1-marc.zyngier@arm.com>
Message-ID: <20170701141637.24719-2-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Contrary to popular belief, PPIs connected to a GICv3 to not have
an affinity field similar to that of GICv2. That is consistent
with the fact that GICv3 is designed to accomodate thousands of
CPUs, and fitting them as a bitmap in a byte is... difficult.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index b4d27857c61b..dbcc3d4e2ed5 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -75,14 +75,10 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13
-			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 14
-			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 11
-			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 10
-			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	soc {
-- 
2.11.0
