From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 10 Dec 2015 17:58:48 +0100
Subject: [PATCH v5 6/7] ARM: dts: Exynos5800: fix CPU OPP
In-Reply-To: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1449766729-435-7-git-send-email-b.zolnierkie@samsung.com>
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
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5800.dtsi | 108 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index c0bb356..b3c16f6 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -23,6 +23,114 @@
 	compatible = "samsung,exynos5800-clock";
 };
 
+&cpu0_opp_table {
+	opp at 1700000000 {
+		opp-microvolt = <1250000>;
+	};
+	opp at 1600000000 {
+		opp-microvolt = <1250000>;
+	};
+	opp at 1500000000 {
+		opp-microvolt = <1100000>;
+	};
+	opp at 1400000000 {
+		opp-microvolt = <1100000>;
+	};
+	opp at 1300000000 {
+		opp-microvolt = <1100000>;
+	};
+	opp at 1200000000 {
+		opp-microvolt = <1000000>;
+	};
+	opp at 1100000000 {
+		opp-microvolt = <1000000>;
+	};
+	opp at 1000000000 {
+		opp-microvolt = <1000000>;
+	};
+	opp at 900000000 {
+		opp-microvolt = <1000000>;
+	};
+	opp at 800000000 {
+		opp-microvolt = <900000>;
+	};
+	opp at 700000000 {
+		opp-microvolt = <900000>;
+	};
+	opp at 600000000 {
+		opp-hz = /bits/ 64 <600000000>;
+		opp-microvolt = <900000>;
+		clock-latency-ns = <140000>;
+	};
+	opp at 500000000 {
+		opp-hz = /bits/ 64 <500000000>;
+		opp-microvolt = <900000>;
+		clock-latency-ns = <140000>;
+	};
+	opp at 400000000 {
+		opp-hz = /bits/ 64 <400000000>;
+		opp-microvolt = <900000>;
+		clock-latency-ns = <140000>;
+	};
+	opp at 300000000 {
+		opp-hz = /bits/ 64 <300000000>;
+		opp-microvolt = <900000>;
+		clock-latency-ns = <140000>;
+	};
+	opp at 200000000 {
+		opp-hz = /bits/ 64 <200000000>;
+		opp-microvolt = <900000>;
+		clock-latency-ns = <140000>;
+	};
+};
+
+&cpu1_opp_table {
+	opp at 1300000000 {
+		opp-microvolt = <1250000>;
+	};
+	opp at 1200000000 {
+		opp-microvolt = <1250000>;
+	};
+	opp at 1100000000 {
+		opp-microvolt = <1250000>;
+	};
+	opp at 1000000000 {
+		opp-microvolt = <1100000>;
+	};
+	opp at 900000000 {
+		opp-microvolt = <1100000>;
+	};
+	opp at 800000000 {
+		opp-microvolt = <1100000>;
+	};
+	opp at 700000000 {
+		opp-microvolt = <1000000>;
+	};
+	opp at 600000000 {
+		opp-microvolt = <1000000>;
+	};
+	opp at 500000000 {
+		opp-hz = /bits/ 64 <500000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <140000>;
+	};
+	opp at 400000000 {
+		opp-hz = /bits/ 64 <400000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <140000>;
+	};
+	opp at 300000000 {
+		opp-hz = /bits/ 64 <300000000>;
+		opp-microvolt = <900000>;
+		clock-latency-ns = <140000>;
+	};
+	opp at 200000000 {
+		opp-hz = /bits/ 64 <200000000>;
+		opp-microvolt = <900000>;
+		clock-latency-ns = <140000>;
+	};
+};
+
 &mfc {
 	compatible = "samsung,mfc-v8";
 };
-- 
1.9.1
