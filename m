From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 24 Apr 2018 19:36:52 +0200
Subject: [RFT][PATCH] arm64: dts: exynos: Remove unneeded address space
 mapping for soc node
Message-ID: <20180424173652.14735-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the address space mapping between root and soc nodes to fix
DTC warnings in Exynos5433 and Exynos7 like:

    arch/arm64/boot/dts/exynos/exynos5433-tm2.dtb:
        Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested.
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 6 +++---
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 828996a06610..ba8157ceaa56 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -18,8 +18,8 @@
 
 / {
 	compatible = "samsung,exynos5433";
-	#address-cells = <2>;
-	#size-cells = <2>;
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	interrupt-parent = <&gic>;
 
@@ -235,7 +235,7 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0x0 0x0 0x0 0x18000000>;
+		ranges;
 
 		arm_a53_pmu {
 			compatible = "arm,cortex-a53-pmu", "arm,armv8-pmuv3";
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 0b98d2334cad..93a84338938a 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -12,8 +12,8 @@
 / {
 	compatible = "samsung,exynos7";
 	interrupt-parent = <&gic>;
-	#address-cells = <2>;
-	#size-cells = <2>;
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	aliases {
 		pinctrl0 = &pinctrl_alive;
@@ -70,7 +70,7 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0 0 0 0x18000000>;
+		ranges;
 
 		chipid at 10000000 {
 			compatible = "samsung,exynos4210-chipid";
-- 
2.14.1
