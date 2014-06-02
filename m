From: chanho61.park@samsung.com (Chanho Park)
Date: Mon, 02 Jun 2014 09:20:45 +0900
Subject: [PATCHv3] ARM: dts: exynos4: clean up arm-pmu node
Message-ID: <1401668445-9810-1-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch cleans a arm-pmu node up for exynos4. Only exynos4412 series
boards have four pmu interrupts. Rest of exynos4 boards, except 4412, have only
two pmu interrupts. Thus, we can define two interrupts in the
exynos4.dtsi and extends the interrupts only exynos4412.dtsi.

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Tested-by: Tushar Behera <tushar.behera@linaro.org>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
Changes from v2:
 - Rebase the patch on top of the kukjin's v3.16-next/dt-samsung-3
Changes from v1:
 - Remove duplicated properties in exynos4412.dtsi(Comment from Tomasz Figa)

 arch/arm/boot/dts/exynos4.dtsi    | 6 ++++++
 arch/arm/boot/dts/exynos4210.dtsi | 6 ------
 arch/arm/boot/dts/exynos4412.dtsi | 4 ++++
 arch/arm/boot/dts/exynos4x12.dtsi | 6 ------
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index b8ece4b..5cb21a7 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -123,6 +123,12 @@
 		reg = <0x10440000 0x1000>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupt-parent = <&combiner>;
+		interrupts = <2 2>, <3 2>;
+	};
+
 	sys_reg: syscon at 10010000 {
 		compatible = "samsung,exynos4-sysreg", "syscon";
 		reg = <0x10010000 0x400>;
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index ee3001f..a4f28e8 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -93,12 +93,6 @@
 		#clock-cells = <1>;
 	};
 
-	pmu {
-		compatible = "arm,cortex-a9-pmu";
-		interrupt-parent = <&combiner>;
-		interrupts = <2 2>, <3 2>;
-	};
-
 	pinctrl_0: pinctrl at 11400000 {
 		compatible = "samsung,exynos4210-pinctrl";
 		reg = <0x11400000 0x1000>;
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index c42a3e1..d8bc059e 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -26,6 +26,10 @@
 		samsung,combiner-nr = <20>;
 	};
 
+	pmu {
+		interrupts = <2 2>, <3 2>, <18 2>, <19 2>;
+	};
+
 	gic: interrupt-controller at 10490000 {
 		cpu-offset = <0x4000>;
 	};
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index c5a943d..95cdfb9 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -31,12 +31,6 @@
 		mshc0 = &mshc_0;
 	};
 
-	pmu {
-		compatible = "arm,cortex-a9-pmu";
-		interrupt-parent = <&combiner>;
-		interrupts = <2 2>, <3 2>, <18 2>, <19 2>;
-	};
-
 	sysram at 02020000 {
 		compatible = "mmio-sram";
 		reg = <0x02020000 0x40000>;
-- 
1.8.3.2
