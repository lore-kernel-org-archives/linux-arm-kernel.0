From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Wed, 28 Aug 2013 16:30:41 +0530
Subject: [PATCH] ARM: DT: Exynos5250: fix number of interrupt-cells in mct node
Message-ID: <1377687641-15376-1-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two cells were used to specify interrupts in mct node, while second cell
always remains unused. Hence use only one cell.
Suggested by Tomasz Figa.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
changes in v2:
	- Drop Changes for Exynos4 as done in separate patch by Tomasz

 arch/arm/boot/dts/exynos5250.dtsi |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index ef57277..f2f178a 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -102,23 +102,22 @@
 		compatible = "samsung,exynos4210-mct";
 		reg = <0x101C0000 0x800>;
 		interrupt-controller;
-		#interrups-cells = <2>;
+		#interrups-cells = <1>;
 		interrupt-parent = <&mct_map>;
-		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
-			     <4 0>, <5 0>;
+		interrupts = <0>, <1>, <2>, <3>, <4>, <5>;
 		clocks = <&clock 1>, <&clock 335>;
 		clock-names = "fin_pll", "mct";
 
 		mct_map: mct-map {
-			#interrupt-cells = <2>;
+			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = <0x0 0 &combiner 23 3>,
-					<0x1 0 &combiner 23 4>,
-					<0x2 0 &combiner 25 2>,
-					<0x3 0 &combiner 25 3>,
-					<0x4 0 &gic 0 120 0>,
-					<0x5 0 &gic 0 121 0>;
+			interrupt-map = <0 &combiner 23 3>,
+					<1 &combiner 23 4>,
+					<2 &combiner 25 2>,
+					<3 &combiner 25 3>,
+					<4 &gic 0 120 0>,
+					<5 &gic 0 121 0>;
 		};
 	};
 
-- 
1.7.9.5
