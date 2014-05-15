From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 15 May 2014 19:32:31 +0200
Subject: [PATCH RFC 4/4] ARM: dts: exynos: Update PMU node with CLKOUT related
 data
In-Reply-To: <1400175151-27779-1-git-send-email-t.figa@samsung.com>
References: <1400175151-27779-1-git-send-email-t.figa@samsung.com>
Message-ID: <1400175151-27779-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends nodes of PMU system controller on Exynos4210, 4x12,
5250 and 5420 SoCs with newly defined properties used by Exynos CLKOUT
driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 10 ++++++++++
 arch/arm/boot/dts/exynos4x12.dtsi |  7 +++++++
 arch/arm/boot/dts/exynos5250.dtsi |  3 +++
 arch/arm/boot/dts/exynos5420.dtsi |  3 +++
 4 files changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index c4e3df9..a9d9b8c 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -31,6 +31,16 @@
 		pinctrl2 = &pinctrl_2;
 	};
 
+	pmu_system_controller: system-controller at 10020000 {
+		#clock-cells = <0>;
+		clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
+				"clkout4", "clkout8", "clkout9";
+		clocks = <&clock CLK_OUT_DMC>, <&clock CLK_OUT_TOP>,
+			<&clock CLK_OUT_LEFTBUS>, <&clock CLK_OUT_RIGHTBUS>,
+			<&clock CLK_OUT_CPU>, <&clock CLK_XXTI>,
+			<&clock CLK_XUSBXTI>;
+	};
+
 	sysram at 02020000 {
 		compatible = "mmio-sysram";
 		reg = <0x02020000 0x20000>;
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index a2889b5..494d296 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -139,6 +139,13 @@
 
 	pmu_system_controller: system-controller at 10020000 {
 		compatible = "samsung,exynos4x12-pmu", "syscon";
+		#clock-cells = <0>;
+		clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
+				"clkout4", "clkout5", "clkout8", "clkout9";
+		clocks = <&clock CLK_OUT_DMC>, <&clock CLK_OUT_TOP>,
+			<&clock CLK_OUT_LEFTBUS>, <&clock CLK_OUT_RIGHTBUS>,
+			<&clock CLK_OUT_CPU>, <&clock CLK_OUT_ISP>,
+			<&clock CLK_XXTI>, <&clock CLK_XUSBXTI>;
 	};
 
 	g2d at 10800000 {
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index e910253..d0a899c 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -191,6 +191,9 @@
 	pmu_system_controller: system-controller at 10040000 {
 		compatible = "samsung,exynos5250-pmu", "syscon";
 		reg = <0x10040000 0x5000>;
+		#clock-cells = <0>;
+		clock-names = "clkout16";
+		clocks = <&clock CLK_FIN_PLL>;
 	};
 
 	watchdog at 101D0000 {
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 0cd65a7..20ee104 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -698,6 +698,9 @@
 	pmu_system_controller: system-controller at 10040000 {
 		compatible = "samsung,exynos5420-pmu", "syscon";
 		reg = <0x10040000 0x5000>;
+		#clock-cells = <0>;
+		clock-names = "clkout16";
+		clocks = <&clock CLK_FIN_PLL>;
 	};
 
 	tmu_cpu0: tmu at 10060000 {
-- 
1.9.2
