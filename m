From: ryder.lee@mediatek.com (Ryder Lee)
Date: Wed, 5 Sep 2018 18:22:17 +0800
Subject: [PATCH 1/5] arm: dts: mt7623: add a performance counter unit device
 node
Message-ID: <84011aa94dd7be9239b7a2f944dd30fc70568fbb.1536141302.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARM PMU device node to enable hardware perf events.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 1cdc346..8c43bd0 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -121,6 +121,15 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 6 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 7 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
 	system_clk: dummy13m {
 		compatible = "fixed-clock";
 		clock-frequency = <13000000>;
-- 
1.9.1
