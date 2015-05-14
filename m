From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Thu, 14 May 2015 19:12:15 +0900
Subject: [PATCH v5 08/13] ARM: dts: Use labels for overriding nodes in
 exynos4412
In-Reply-To: <1431598340-3319-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431598340-3319-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431598340-3319-9-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos4412.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 68ad43b391ae..b78ada70bd05 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -54,19 +54,19 @@
 		};
 	};
 
-	combiner: interrupt-controller at 10440000 {
-		samsung,combiner-nr = <20>;
-	};
-
 	pmu {
 		interrupts = <2 2>, <3 2>, <18 2>, <19 2>;
 	};
+};
 
-	gic: interrupt-controller at 10490000 {
-		cpu-offset = <0x4000>;
-	};
+&pmu_system_controller {
+	compatible = "samsung,exynos4412-pmu", "syscon";
+};
 
-	pmu_system_controller: system-controller at 10020000 {
-		compatible = "samsung,exynos4412-pmu", "syscon";
-	};
+&combiner {
+	samsung,combiner-nr = <20>;
+};
+
+&gic {
+	cpu-offset = <0x4000>;
 };
-- 
2.1.4
