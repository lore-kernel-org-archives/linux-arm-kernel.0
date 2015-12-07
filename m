From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 07 Dec 2015 19:18:18 +0100
Subject: [PATCH v4 6/8] ARM: dts: Exynos5800: fix CPU OPP
In-Reply-To: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1449512300-17230-7-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix CPU operating points for Exynos5800 (it use different
voltages than Exynos5420 and supports additional frequencies).
However don't use 2000MHz & 1900MHz OPPs (for A15 cores) and
1400MHz OPP (for A7 cores) for now as they are not available
on all boards.

Based on Hardkernel's kernel for ODROID-XU3 board.

Changes by Ben Gamari:
- Port to operating-points-v2

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5800.dtsi | 165 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index c0bb356..e417218 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -17,8 +17,173 @@
 
 / {
 	compatible = "samsung,exynos5800", "samsung,exynos5";
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00 at 1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp01 at 1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp02 at 1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp03 at 1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <140000>;
+		};
+		opp04 at 1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <140000>;
+		};
+		opp05 at 1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <140000>;
+		};
+		opp06 at 1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp07 at 1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp08 at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp09 at 900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp10 at 800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+		opp11 at 700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+		opp12 at 600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+		opp13 at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+		opp14 at 400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+		opp15 at 300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+		opp16 at 200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+	};
+
+	cpu1_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00 at 1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp01 at 1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp02 at 1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp03 at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <140000>;
+		};
+		opp04 at 900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <140000>;
+		};
+		opp05 at 800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <140000>;
+		};
+		opp06 at 700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp07 at 600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp08 at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp09 at 400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp10 at 300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+		opp11 at 200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
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
1.9.1
