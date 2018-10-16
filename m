From: l.luba@partner.samsung.com (Lukasz Luba)
Date: Tue, 16 Oct 2018 16:56:20 +0200
Subject: [PATCH 09/11] DT: arm: exynos: add support for thermal trip irq-mode
In-Reply-To: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8@eucas1p1.samsung.com>
Message-ID: <20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8~eHqPK-tM31616816168eucas1p1y@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for new flash which indicates
that trip point triggers irq when temperature is met.
Exynos5433 supports 8 trip point which will trigger irq.
Above that number other trip points should be registered
without 'irq-mode' flag.
That will force the thermal framework to start polling
the temperature sensor under configured conditions and
handle the trip point.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420-trip-points.dtsi | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-trip-points.dtsi b/arch/arm/boot/dts/exynos5420-trip-points.dtsi
index a67a3807..9e16970 100644
--- a/arch/arm/boot/dts/exynos5420-trip-points.dtsi
+++ b/arch/arm/boot/dts/exynos5420-trip-points.dtsi
@@ -11,21 +11,25 @@ trips {
 	cpu-alert-0 {
 		temperature = <85000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "active";
+		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-1 {
 		temperature = <103000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "active";
+		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-2 {
 		temperature = <110000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "active";
+		type = "passive";
+		irq-mode;
 	};
 	cpu-crit-0 {
 		temperature = <120000>; /* millicelsius */
 		hysteresis = <0>; /* millicelsius */
 		type = "critical";
+		irq-mode;
 	};
 };
-- 
2.7.4
