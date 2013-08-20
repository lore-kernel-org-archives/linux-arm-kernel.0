From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 15:52:44 +0200
Subject: [PATCH 4/8] ARM: dts: exynos4: Simplify MCT interrupt map
In-Reply-To: <1377006768-23174-1-git-send-email-t.figa@samsung.com>
References: <1377006768-23174-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377006768-23174-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to use two cells for interrupt specifiers inside the
MCT interrupt map, so this patch simplifies the map to use one cell.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 17 ++++++++---------
 arch/arm/boot/dts/exynos4x12.dtsi | 14 +++++++-------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 1a6440ae6..b0fee69 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -52,21 +52,20 @@
 		compatible = "samsung,exynos4210-mct";
 		reg = <0x10050000 0x800>;
 		interrupt-parent = <&mct_map>;
-		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
-			     <4 0>, <5 0>;
+		interrupts = <0>, <1>, <2>, <3>, <4>, <5>;
 		clocks = <&clock 3>, <&clock 344>;
 		clock-names = "fin_pll", "mct";
 
 		mct_map: mct-map {
-			#interrupt-cells = <2>;
+			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = <0x0 0 &gic 0 57 0>,
-					<0x1 0 &gic 0 69 0>,
-					<0x2 0 &combiner 12 6>,
-					<0x3 0 &combiner 12 7>,
-					<0x4 0 &gic 0 42 0>,
-					<0x5 0 &gic 0 48 0>;
+			interrupt-map = <0 &gic 0 57 0>,
+					<1 &gic 0 69 0>,
+					<2 &combiner 12 6>,
+					<3 &combiner 12 7>,
+					<4 &gic 0 42 0>,
+					<5 &gic 0 48 0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 5012bc8..3d7182a 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -45,19 +45,19 @@
 		compatible = "samsung,exynos4412-mct";
 		reg = <0x10050000 0x800>;
 		interrupt-parent = <&mct_map>;
-		interrupts = <0 0>, <1 0>, <2 0>, <3 0>, <4 0>;
+		interrupts = <0>, <1>, <2>, <3>, <4>;
 		clocks = <&clock 3>, <&clock 344>;
 		clock-names = "fin_pll", "mct";
 
 		mct_map: mct-map {
-			#interrupt-cells = <2>;
+			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = <0x0 0 &gic 0 57 0>,
-					<0x1 0 &combiner 12 5>,
-					<0x2 0 &combiner 12 6>,
-					<0x3 0 &combiner 12 7>,
-					<0x4 0 &gic 1 12 0>;
+			interrupt-map = <0 &gic 0 57 0>,
+					<1 &combiner 12 5>,
+					<2 &combiner 12 6>,
+					<3 &combiner 12 7>,
+					<4 &gic 1 12 0>;
 		};
 	};
 
-- 
1.8.3.2
