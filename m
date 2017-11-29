From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 29 Nov 2017 19:36:10 +0100
Subject: [PATCH] ARM: dts: exynos: Add missing interrupt-controller properties
 to Exynos5410 PMU
Message-ID: <20171129183610.26305-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PMU (system-controller at 10040000) is used as interrupt-parent for certain
nodes thus it should be marked as interrupt-controller to silence
warnings when building Exynos5410-based DTBs:

  arch/arm/boot/dts/exynos5410-odroidxu.dtb: Warning (interrupts_property):
    Missing interrupt-controller or interrupt-map property in /soc/system-controller at 10040000
  arch/arm/boot/dts/exynos5410-odroidxu.dtb: Warning (interrupts_property):
    Missing #interrupt-cells in interrupt-parent /soc/system-controller at 10040000

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5410.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 06713ec86f0d..e234219fe8f1 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -75,6 +75,9 @@
 			clock-names = "clkout16";
 			clocks = <&fin_pll>;
 			#clock-cells = <1>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
 		};
 
 		clock: clock-controller at 10010000 {
-- 
2.11.0
