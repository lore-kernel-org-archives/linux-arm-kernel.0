From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 07 Sep 2015 17:41:41 +0200
Subject: [PATCH v4 4/4] ARM: dts: add suspend opp to exynos4412
In-Reply-To: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
References: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1441640501-13613-5-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark 800MHz OPP as a suspend opp for Exynos4412 based
boards so effectively cpufreq-dt driver behavior w.r.t.
suspend frequency matches what the old exynos-cpufreq
driver has been doing.

This patch fixes suspend/resume support on Exynos4412 based
Trats2 board and reboot hang on Exynos4412 based Odroid U3
board.

Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos4412.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index ca0e3c1..294cfe4 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -98,6 +98,7 @@
 			opp-hz = /bits/ 64 <800000000>;
 			opp-microvolt = <1000000>;
 			clock-latency-ns = <200000>;
+			opp-suspend;
 		};
 		opp07 {
 			opp-hz = /bits/ 64 <900000000>;
-- 
1.9.1
