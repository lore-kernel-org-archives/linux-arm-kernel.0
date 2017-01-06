From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 06 Jan 2017 22:43:46 +0900
Subject: [PATCH v5 1/5] arm64: dts: exynos5433: TM2/E: Fix wrong values for
 ldo23 and ldo25
In-Reply-To: <20170106134350.32428-1-andi.shyti@samsung.com>
References: <20170106134350.32428-1-andi.shyti@samsung.com>
 <CGME20170106134355epcas1p1c201edf5dabed68506eb6bf9f9e0a1ee@epcas1p1.samsung.com>
Message-ID: <20170106134350.32428-2-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chanwoo Choi <cw00.choi@samsung.com>

This patch fixes wrong values assigned to ldo23 and ldo25 on both TM2 and TM2E.

Fixes: 01e5d2352152 ("arm64: dts: exynos: Add dts file for Exynos5433-based TM2 board")
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts  | 6 +++---
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts | 9 ---------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
index 3b5215c40fcd..640e4b9910ae 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
@@ -504,9 +504,9 @@
 			};
 
 			ldo23_reg: LDO23 {
-				regulator-name = "CAM_SEN_CORE_1.2V_AP";
+				regulator-name = "CAM_SEN_CORE_1.05V_AP";
 				regulator-min-microvolt = <1050000>;
-				regulator-max-microvolt = <1200000>;
+				regulator-max-microvolt = <1050000>;
 			};
 
 			ldo24_reg: LDO24 {
@@ -516,7 +516,7 @@
 			};
 
 			ldo25_reg: LDO25 {
-				regulator-name = "CAM_SEN_A2.8V_AP";
+				regulator-name = "UNUSED_LDO25";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 			};
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
index 398f5e092b02..854c583092d5 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
@@ -18,15 +18,6 @@
 	compatible = "samsung,tm2e", "samsung,exynos5433";
 };
 
-&ldo23_reg {
-	regulator-name = "CAM_SEN_CORE_1.025V_AP";
-	regulator-max-microvolt = <1050000>;
-};
-
-&ldo25_reg {
-	regulator-name = "UNUSED_LDO25";
-};
-
 &ldo31_reg {
 	regulator-name = "TSP_VDD_1.8V_AP";
 	regulator-min-microvolt = <1800000>;
-- 
2.11.0
