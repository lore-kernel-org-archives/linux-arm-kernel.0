From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu,  4 Apr 2013 19:46:46 +0900
Subject: [PATCH 3/4] ARM: dts: add PMU support in exynos5440
In-Reply-To: <1365072407-4320-1-git-send-email-kgene.kim@samsung.com>
References: <1365072407-4320-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1365072407-4320-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Subash Patel <subash.rp@samsung.com>

PMU in exynos5440 generates one interrupt per core and needs to
be passed from DT to GIC to register it.

Signed-off-by: Subash Patel <subash.rp@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 715ea15..5a339f0 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -55,6 +55,14 @@
 		};
 	};
 
+	arm-pmu {
+		compatible = "arm,cortex-a15-pmu", "arm,cortex-a9-pmu";
+		interrupts = <0 52 4>,
+			     <0 53 4>,
+			     <0 54 4>,
+			     <0 55 4>;
+	};
+
 	timer {
 		compatible = "arm,cortex-a15-timer",
 			     "arm,armv7-timer";
-- 
1.7.4.4
