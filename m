From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 24 Feb 2015 14:16:48 +0900
Subject: [PATCH v4 5/8] arm64: dts: exynos: Add PMU dt node for Exynos5433
In-Reply-To: <1424755011-15999-1-git-send-email-cw00.choi@samsung.com>
References: <1424755011-15999-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1424755011-15999-6-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds PMU (Power Management Unit) dt node for Exynos5433 SoC and
set the source clock for CLKOUT register as xxti .

Cc: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
[ideal.song: Add the setting of CLKOUT register]
Signed-off-by: Inha Song <ideal.song@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
---
 Documentation/devicetree/bindings/arm/samsung/pmu.txt | 1 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi            | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
index 67b2113..a87fc43 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
@@ -10,6 +10,7 @@ Properties:
 		   - "samsung,exynos5260-pmu" - for Exynos5260 SoC.
 		   - "samsung,exynos5410-pmu" - for Exynos5410 SoC,
 		   - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
+		   - "samsung,exynos5433-pmu" - for Exynos5433 SoC.
 		   - "samsung,exynos7-pmu" - for Exynos7 SoC.
 		second value must be always "syscon".
 
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 1b18fd3..84be8e2 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -844,6 +844,14 @@
 			status = "disabled";
 		};
 
+		pmu_system_controller: system-controller at 105c0000 {
+			compatible = "samsung,exynos5433-pmu", "syscon";
+			reg = <0x105c0000 0x5008>;
+			#clock-cells = <1>;
+			clock-names = "clkout16";
+			clocks = <&xxti>;
+		};
+
 		timer {
 			compatible = "arm,armv8-timer";
 			interrupts = <1 13 0xff04>,
-- 
1.8.5.5
