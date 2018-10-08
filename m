From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 08 Oct 2018 14:50:07 +0200
Subject: [PATCH 5/7] arm64: dts: exynos: Move arch-timer node to right place
In-Reply-To: <20181008125009.3721-1-m.szyprowski@samsung.com>
References: <20181008125009.3721-1-m.szyprowski@samsung.com>
 <CGME20181008125049eucas1p21a186cd652f968a3609987d4dee2427f@eucas1p2.samsung.com>
Message-ID: <20181008125009.3721-6-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move ARM architected timer device-tree node to the beginning of 'soc'
node, to group it together with other ARM CPU core devices (like PMU).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 23 +++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 77297d66642c..eee3d1d1b52f 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -290,6 +290,18 @@
 			interrupt-affinity = <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
 		};
 
+		timer: timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <GIC_PPI 13
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
+				<GIC_PPI 14
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
+				<GIC_PPI 11
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
+				<GIC_PPI 10
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
 		sysram at 2020000 {
 			compatible = "mmio-sram";
 			reg = <0x02020000 0x5c000>;
@@ -1811,17 +1823,6 @@
 		};
 	};
 
-	timer: timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13
-				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
-			<GIC_PPI 14
-				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
-			<GIC_PPI 11
-				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
-			<GIC_PPI 10
-				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
-	};
 };
 
 #include "exynos5433-bus.dtsi"
-- 
2.17.1
