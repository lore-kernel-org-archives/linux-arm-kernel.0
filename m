From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 05 Sep 2014 13:30:19 +0900
Subject: [RFC PATCH 5/5] ARM: dts: Add dt node fo PPMU_CPU/DMC0/DMC1 for
 exynos4412-trats2
In-Reply-To: <1409891419-28560-1-git-send-email-cw00.choi@samsung.com>
References: <1409891419-28560-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1409891419-28560-6-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add dt node for PPMU_CPU/DMC0/DMC1 for exynos4412-trats2 board.
Each PPMU dt node includes one event of 'PPMU Count 3'

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 11967f4..00dcb91 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -770,6 +770,35 @@
 		status = "okay";
 	};
 
+	ppmu_cpu: ppmu_cpu at 106c0000 {
+		status = "okay";
+
+		events {
+			ppmu_cpu_3: ppmu-cpu-pmcnt3 {
+				event-name = "ppmu-cpu-pmcnt3";
+			};
+		};
+	};
+
+	ppmu_dmc0: ppmu_dmc0 at 106a0000 {
+		status = "okay";
+
+		events {
+			ppmu_dmc0_3: ppmu-dmc0-pmcnt3 {
+				event-name = "ppmu-dmc0-pmcnt3";
+			};
+		};
+	};
+
+	ppmu_dmc1: ppmu_dmc1 at 106b0000 {
+		status = "okay";
+
+		events {
+			ppmu_dmc1_3: ppmu-dmc1-pmcnt3 {
+				event-name = "ppmu-dmc1-pmcnt3";
+		};
+	};
+
 	thermistor-ap at 0 {
 		compatible = "ntc,ncp15wb473";
 		pullup-uv = <1800000>;	 /* VCC_1.8V_AP */
-- 
1.8.0
