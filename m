From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 15 Dec 2015 22:36:12 +0800
Subject: [PATCH] arm64: dts: berlin4ct: switch to Cortex-A53 specific pmu nodes
Message-ID: <1450190172-1161-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ac82d1277215 ("arm64: perf: add Cortex-A53 support") adds the
cortex A53 PMU support, thus instead of using the generic armv8-pmuv3
compatibility use the more specific Cortex A53 compatibility.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index 099ad93..e48d424 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
@@ -115,7 +115,7 @@
 	};
 
 	pmu {
-		compatible = "arm,armv8-pmuv3";
+		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.6.4
