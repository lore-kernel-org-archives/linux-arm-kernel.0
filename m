From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri, 17 Oct 2014 21:41:53 +0530
Subject: [PATCH 5/7] arm64: dts: Add PMU DT node for exynos7 SoC
In-Reply-To: <1413562315-12283-1-git-send-email-a.kesavan@samsung.com>
References: <1413562315-12283-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1413562315-12283-6-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds PMU DT node for exynos7 SoC.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 .../devicetree/bindings/arm/samsung/pmu.txt        |    1 +
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |    5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
index 1e1979b..67b2113 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
@@ -10,6 +10,7 @@ Properties:
 		   - "samsung,exynos5260-pmu" - for Exynos5260 SoC.
 		   - "samsung,exynos5410-pmu" - for Exynos5410 SoC,
 		   - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
+		   - "samsung,exynos7-pmu" - for Exynos7 SoC.
 		second value must be always "syscon".
 
  - reg : offset and length of the register set.
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index ce221ac..6db8c78 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -243,6 +243,11 @@
 				     <1 11 0xff01>,
 				     <1 10 0xff01>;
 		};
+
+		pmu_system_controller: system-controller at 105c0000 {
+			compatible = "samsung,exynos7-pmu", "syscon";
+			reg = <0x105c0000 0x5000>;
+		};
 	};
 };
 
-- 
1.7.9.5
