From: linux.amoon@gmail.com (Anand Moon)
Date: Fri, 23 Nov 2018 09:44:13 +0000
Subject: [PATCH 3/3] ARM: dts: Add g3d bus nodes using VDD_INT for Exynos542x
 SoC
In-Reply-To: <20181123094413.1108-1-linux.amoon@gmail.com>
References: <20181123094413.1108-1-linux.amoon@gmail.com>
Message-ID: <20181123094413.1108-3-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing Netwwork on chip for g3d bus node using VDD_INI
for Exynos542x SoC.

- CLK_DOUT_ACLK_G3D for G3D's AXI

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi             | 57 +++++++++++++++++--
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  5 ++
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index aaff15880761..bc7203bb1282 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1047,6 +1047,14 @@
 			status = "disabled";
 		};
 
+		bus_g3d: bus_g3d {
+			compatible = "samsung,exynos-bus";
+			clocks = <&clock CLK_DOUT_ACLK_G3D>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_g3d_opp_table>;
+			status = "disabled";
+		};
+
 		bus_jpeg: bus_jpeg {
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK300_JPEG>;
@@ -1245,7 +1253,44 @@
 			};
 		};
 
-		bus_jpeg_opp_table: opp_table11 {
+		bus_g3d_opp_table: opp_table11 {
+			compatible = "operating-points-v2";
+
+			opp at 600000000 {
+				opp-hz = /bits/ 64 <600000000>;
+				opp-microvolt = <1025000>;
+			};
+			opp at 543000000 {
+				opp-hz = /bits/ 64 <543000000>;
+				opp-microvolt = <987500>;
+			};
+			opp at 480000000 {
+				opp-hz = /bits/ 64 <480000000>;
+				opp-microvolt = <950000>;
+			};
+			opp at 420000000 {
+				opp-hz = /bits/ 64 <420000000>;
+				opp-microvolt = <937500>;
+			};
+			opp at 350000000 {
+				opp-hz = /bits/ 64 <350000000>;
+				opp-microvolt = <900000>;
+			};
+			opp at 266000000 {
+				opp-hz = /bits/ 64 <266000000>;
+				opp-microvolt = <862500>;
+			};
+			opp at 177000000 {
+				opp-hz = /bits/ 64 <177000000>;
+				opp-microvolt = <862500>;
+			};
+			opp at 100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+				opp-microvolt = <862500>;
+			};
+		};
+
+		bus_jpeg_opp_table: opp_table12 {
 			compatible = "operating-points-v2";
 
 			opp00 {
@@ -1262,7 +1307,7 @@
 			};
 		};
 
-		bus_jpeg_apb_opp_table: opp_table12 {
+		bus_jpeg_apb_opp_table: opp_table13 {
 			compatible = "operating-points-v2";
 
 			opp00 {
@@ -1279,7 +1324,7 @@
 			};
 		};
 
-		bus_disp1_fimd_opp_table: opp_table13 {
+		bus_disp1_fimd_opp_table: opp_table14 {
 			compatible = "operating-points-v2";
 
 			opp00 {
@@ -1290,7 +1335,7 @@
 			};
 		};
 
-		bus_disp1_opp_table: opp_table14 {
+		bus_disp1_opp_table: opp_table15 {
 			compatible = "operating-points-v2";
 
 			opp00 {
@@ -1304,7 +1349,7 @@
 			};
 		};
 
-		bus_gscl_opp_table: opp_table15 {
+		bus_gscl_opp_table: opp_table16 {
 			compatible = "operating-points-v2";
 
 			opp00 {
@@ -1318,7 +1363,7 @@
 			};
 		};
 
-		bus_mscl_opp_table: opp_table16 {
+		bus_mscl_opp_table: opp_table17 {
 			compatible = "operating-points-v2";
 
 			opp00 {
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 2fac4baf1eb4..6e39e4594502 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -89,6 +89,11 @@
 	status = "okay";
 };
 
+&bus_g3d {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
 &bus_jpeg {
 	devfreq = <&bus_wcore>;
 	status = "okay";
-- 
2.17.1
