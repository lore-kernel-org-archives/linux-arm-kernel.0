From: rasmus.villemoes@prevas.dk (Rasmus Villemoes)
Date: Tue, 14 Nov 2017 16:09:48 +0100
Subject: [PATCH] arm: dts: ls1021a: Specify interrupt-affinity for pmu node
Message-ID: <1510672189-13306-1-git-send-email-rasmus.villemoes@prevas.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Esben Haabendal <eha@deif.com>

This avoids the warning

  hw perfevents: no interrupt-affinity property for /pmu, guessing.

Signed-off-by: Esben Haabendal <eha@deif.com>
[RV: adapt commit log to the warning emitted in current mainline]
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/arm/boot/dts/ls1021a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 9319e1f..d62af07 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -106,6 +106,7 @@
 		compatible = "arm,cortex-a7-pmu";
 		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>;
 	};
 
 	soc {
-- 
2.7.4
