From: ben@smart-cactus.org (Ben Gamari)
Date: Wed,  2 Dec 2015 22:19:21 +0100
Subject: [PATCH 06/12] ARM: dts: Exynos5800: fix CPU OPP
In-Reply-To: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
Message-ID: <1449091167-20758-7-git-send-email-ben@smart-cactus.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Fix CPU operating points for Exynos5800 (it uses different
voltages than Exynos5420 and supports additional frequencies).
However don't use 2000MHz & 1900MHz OPPs (for A15 cores) and
1400MHz OPP (for A7 cores) until there is a separate DTS for
ODROID-XU3 Lite board (which doesn't support these higher
OPPs).

Based on Hardkernel's kernel for ODROID-XU3 board.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
---
 arch/arm/boot/dts/exynos5800.dtsi | 136 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index c0bb356..43d42f4 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -17,8 +17,144 @@
 
 / {
 	compatible = "samsung,exynos5800", "samsung,exynos5";
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1250000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <1250000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1250000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1100000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <1100000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1100000>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp07 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp08 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp09 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp10 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <900000>;
+		};
+		opp11 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <900000>;
+		};
+		opp12 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <900000>;
+		};
+		opp13 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <900000>;
+		};
+		opp14 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <900000>;
+		};
+		opp15 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <900000>;
+		};
+		opp16 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <900000>;
+		};
+	};
+
+	cpu1_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1250000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1250000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1250000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1100000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1100000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1100000>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp07 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp08 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp09 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp10 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <900000>;
+		};
+		opp11 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <900000>;
+		};
+	};
 };
 
+&cpu0 { operating-points-v2 = <&cpu0_opp_table>; };
+&cpu1 { operating-points-v2 = <&cpu0_opp_table>; };
+&cpu2 { operating-points-v2 = <&cpu0_opp_table>; };
+&cpu3 { operating-points-v2 = <&cpu0_opp_table>; };
+
+&cpu4 { operating-points-v2 = <&cpu1_opp_table>; };
+&cpu5 { operating-points-v2 = <&cpu1_opp_table>; };
+&cpu6 { operating-points-v2 = <&cpu1_opp_table>; };
+&cpu7 { operating-points-v2 = <&cpu1_opp_table>; };
+
 &clock {
 	compatible = "samsung,exynos5800-clock";
 };
-- 
2.6.2
