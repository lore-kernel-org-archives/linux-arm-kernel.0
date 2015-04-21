From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 21 Apr 2015 17:49:04 +0200
Subject: [PATCH v2 7/8] ARM: dts: Exynos5800: fix CPU OPP
In-Reply-To: <1429631345-16409-1-git-send-email-b.zolnierkie@samsung.com>
References: <1429631345-16409-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1429631345-16409-8-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix CPU operating points for Exynos5800 (it uses different
voltages than Exynos5420 and supports additional frequencies).
However don't use 2000MHz & 1900MHz OPPs (for A15 cores) and
1400MHz OPP (for A7 cores) until there is a separate DTS for
ODROID-XU3 Lite board (which doesn't support these higher
OPPs).

Based on Hardkernel's kernel for ODROID-XU3 board.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5800.dtsi |   39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index c0bb356..ba7ecd2 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -19,6 +19,45 @@
 	compatible = "samsung,exynos5800", "samsung,exynos5";
 };
 
+&cpu0 {
+	operating-points = <
+		1800000 1250000
+		1700000 1250000
+		1600000 1250000
+		1500000 1100000
+		1400000 1100000
+		1300000 1100000
+		1200000 1000000
+		1100000 1000000
+		1000000 1000000
+		 900000 1000000
+		 800000  900000
+		 700000  900000
+		 600000  900000
+		 500000  900000
+		 400000  900000
+		 300000  900000
+		 200000  900000
+	>;
+};
+
+&cpu4 {
+	operating-points = <
+		1300000 1250000
+		1200000 1250000
+		1100000 1250000
+		1000000 1100000
+		 900000 1100000
+		 800000 1100000
+		 700000 1000000
+		 600000 1000000
+		 500000 1000000
+		 400000 1000000
+		 300000  900000
+		 200000  900000
+	>;
+};
+
 &clock {
 	compatible = "samsung,exynos5800-clock";
 };
-- 
1.7.9.5
