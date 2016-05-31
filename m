From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 31 May 2016 20:39:03 +0200
Subject: [PATCH 4/6] ARM: dts: exynos: Add Thermal Management Unit to
 Exynos5410
In-Reply-To: <1464719945-3417-1-git-send-email-krzk@kernel.org>
References: <1464719945-3417-1-git-send-email-krzk@kernel.org>
Message-ID: <1464719945-3417-4-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for Thermal Management Unit to exynos5410.dtsi. Use the same
compatible as for Exynos5420 however without second base for TRIMINFO
register.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5410.dtsi | 55 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 994d16a44fe4..f1effd3f03c4 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -81,6 +81,42 @@
 			#clock-cells = <1>;
 		};
 
+		tmu_cpu0: tmu at 10060000 {
+			compatible = "samsung,exynos5420-tmu";
+			reg = <0x10060000 0x100>;
+			interrupts = <0 65 0>;
+			clocks = <&clock CLK_TMU>;
+			clock-names = "tmu_apbif";
+			#include "exynos4412-tmu-sensor-conf.dtsi"
+		};
+
+		tmu_cpu1: tmu at 10064000 {
+			compatible = "samsung,exynos5420-tmu";
+			reg = <0x10064000 0x100>;
+			interrupts = <0 183 0>;
+			clocks = <&clock CLK_TMU>;
+			clock-names = "tmu_apbif";
+			#include "exynos4412-tmu-sensor-conf.dtsi"
+		};
+
+		tmu_cpu2: tmu at 10068000 {
+			compatible = "samsung,exynos5420-tmu";
+			reg = <0x10068000 0x100>;
+			interrupts = <0 184 0>;
+			clocks = <&clock CLK_TMU>;
+			clock-names = "tmu_apbif";
+			#include "exynos4412-tmu-sensor-conf.dtsi"
+		};
+
+		tmu_cpu3: tmu at 1006c000 {
+			compatible = "samsung,exynos5420-tmu";
+			reg = <0x1006c000 0x100>;
+			interrupts = <0 185 0>;
+			clocks = <&clock CLK_TMU>;
+			clock-names = "tmu_apbif";
+			#include "exynos4412-tmu-sensor-conf.dtsi"
+		};
+
 		mmc_0: mmc at 12200000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12200000 0x1000>;
@@ -147,6 +183,25 @@
 			interrupts = <0 47 0>;
 		};
 	};
+
+	thermal-zones {
+		cpu0_thermal: cpu0-thermal {
+			thermal-sensors = <&tmu_cpu0>;
+			#include "exynos5420-trip-points.dtsi"
+		};
+		cpu1_thermal: cpu1-thermal {
+		       thermal-sensors = <&tmu_cpu1>;
+		       #include "exynos5420-trip-points.dtsi"
+		};
+		cpu2_thermal: cpu2-thermal {
+		       thermal-sensors = <&tmu_cpu2>;
+		       #include "exynos5420-trip-points.dtsi"
+		};
+		cpu3_thermal: cpu3-thermal {
+		       thermal-sensors = <&tmu_cpu3>;
+		       #include "exynos5420-trip-points.dtsi"
+		};
+	};
 };
 
 &i2c_0 {
-- 
2.7.4
