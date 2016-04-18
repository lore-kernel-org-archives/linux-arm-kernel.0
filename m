From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 18 Apr 2016 09:44:13 +0200
Subject: [PATCH] ARM: dts: exynos: Remove unsupported s2mps11 regulator
 bindings from Exynos5420 boards
Message-ID: <1460965453-5337-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bindings like s2mps11,buck6-ramp-enable or s2mps11,buck2-ramp-delay
where ignored. They were never parse by s2mps11 regulator driver. Also
the values used in these bindings were equal to default reset values of
S2MPS11 device. It is safe to remove them.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      | 7 -------
 arch/arm/boot/dts/exynos5420-smdk5420.dts          | 7 -------
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 7 -------
 3 files changed, 21 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index a103ce8c3985..60bc861d0f9d 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -75,13 +75,6 @@
 	s2mps11_pmic at 66 {
 		compatible = "samsung,s2mps11-pmic";
 		reg = <0x66>;
-		s2mps11,buck2-ramp-delay = <12>;
-		s2mps11,buck34-ramp-delay = <12>;
-		s2mps11,buck16-ramp-delay = <12>;
-		s2mps11,buck6-ramp-enable = <1>;
-		s2mps11,buck2-ramp-enable = <1>;
-		s2mps11,buck3-ramp-enable = <1>;
-		s2mps11,buck4-ramp-enable = <1>;
 
 		interrupt-parent = <&gpx3>;
 		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 49920b4330ed..2e748d19322f 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -140,13 +140,6 @@
 	s2mps11_pmic at 66 {
 		compatible = "samsung,s2mps11-pmic";
 		reg = <0x66>;
-		s2mps11,buck2-ramp-delay = <12>;
-		s2mps11,buck34-ramp-delay = <12>;
-		s2mps11,buck16-ramp-delay = <12>;
-		s2mps11,buck6-ramp-enable = <1>;
-		s2mps11,buck2-ramp-enable = <1>;
-		s2mps11,buck3-ramp-enable = <1>;
-		s2mps11,buck4-ramp-enable = <1>;
 
 		s2mps11_osc: clocks {
 			#clock-cells = <1>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 0e71d4253205..20fa7612080d 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -92,13 +92,6 @@
 	s2mps11_pmic at 66 {
 		compatible = "samsung,s2mps11-pmic";
 		reg = <0x66>;
-		s2mps11,buck2-ramp-delay = <12>;
-		s2mps11,buck34-ramp-delay = <12>;
-		s2mps11,buck16-ramp-delay = <12>;
-		s2mps11,buck6-ramp-enable = <1>;
-		s2mps11,buck2-ramp-enable = <1>;
-		s2mps11,buck3-ramp-enable = <1>;
-		s2mps11,buck4-ramp-enable = <1>;
 		samsung,s2mps11-acokb-ground;
 
 		interrupt-parent = <&gpx0>;
-- 
1.9.1
