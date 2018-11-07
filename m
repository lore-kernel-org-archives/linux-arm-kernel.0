From: l.luba@partner.samsung.com (Lukasz Luba)
Date: Wed,  7 Nov 2018 18:09:51 +0100
Subject: [PATCH v2 09/11] arm: dts: exynos5420: add support for thermal trip
 irq-mode
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181107171044eucas1p198434e21cf21ee754302615a6a8f3c20@eucas1p1.samsung.com>
Message-ID: <1541610593-28542-10-git-send-email-l.luba@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for new flag which indicates
that trip point triggers IRQ when temperature is met.
Change existing trip points to be expicitly marked with the new flag.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
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
