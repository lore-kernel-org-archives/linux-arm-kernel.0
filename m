From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Apr 2014 19:06:11 +0900
Subject: [PATCH 21/27] ARM: dts: exynos3250: Add PMU dt data
In-Reply-To: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1397124377-16969-13-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hyunhee Kim <hyunhee.kim@samsung.com>

ARM CPU has its own PMU (Performance Monitoring Unit). This patch add PMU dt
data to support PMU for CPU. Exynos3250 has four PMU interrupts.

Signed-off-by: Hyunhee Kim <hyunhee.kim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index ceed761..2f0ca32 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -280,4 +280,9 @@
 		pinctrl-0 = <&i2c7_bus>;
 		status = "disabled";
 	};
+
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <0 18 0>, <0 19 0>, <0 20 0>, <0 21 0>;
+	};
 };
-- 
1.8.0
