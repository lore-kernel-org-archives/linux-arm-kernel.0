From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Thu, 14 May 2015 19:12:09 +0900
Subject: [PATCH v5 02/13] ARM: dts: Use labels for overriding nodes in
 exynos4210
In-Reply-To: <1431598340-3319-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431598340-3319-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431598340-3319-3-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 43 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 76b84852f29c..a9a55304e31a 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -52,16 +52,6 @@
 		};
 	};
 
-	pmu_system_controller: system-controller at 10020000 {
-		clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
-				"clkout4", "clkout8", "clkout9";
-		clocks = <&clock CLK_OUT_DMC>, <&clock CLK_OUT_TOP>,
-			<&clock CLK_OUT_LEFTBUS>, <&clock CLK_OUT_RIGHTBUS>,
-			<&clock CLK_OUT_CPU>, <&clock CLK_XXTI>,
-			<&clock CLK_XUSBXTI>;
-		#clock-cells = <1>;
-	};
-
 	sysram: sysram at 02020000 {
 		compatible = "mmio-sram";
 		reg = <0x02020000 0x20000>;
@@ -95,18 +85,6 @@
 		arm,data-latency = <2 2 1>;
 	};
 
-	gic: interrupt-controller at 10490000 {
-		cpu-offset = <0x8000>;
-	};
-
-	combiner: interrupt-controller at 10440000 {
-		samsung,combiner-nr = <16>;
-		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
-			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
-			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
-			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
-	};
-
 	mct: mct at 10050000 {
 		compatible = "samsung,exynos4210-mct";
 		reg = <0x10050000 0x800>;
@@ -245,3 +223,24 @@
 		status = "disabled";
 	};
 };
+
+&gic {
+	cpu-offset = <0x8000>;
+};
+
+&combiner {
+	samsung,combiner-nr = <16>;
+	interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
+		     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
+		     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
+		     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
+};
+
+&pmu_system_controller {
+	clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
+			"clkout4", "clkout8", "clkout9";
+	clocks = <&clock CLK_OUT_DMC>, <&clock CLK_OUT_TOP>,
+		<&clock CLK_OUT_LEFTBUS>, <&clock CLK_OUT_RIGHTBUS>,
+		<&clock CLK_OUT_CPU>, <&clock CLK_XXTI>, <&clock CLK_XUSBXTI>;
+	#clock-cells = <1>;
+};
-- 
2.1.4
