From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 25 Jul 2018 17:55:16 +0200
Subject: [PATCH 2/3] ARM: dts: exynos: Add compatible for s2mps11 clocks node
 on Exynos542x
In-Reply-To: <20180725155517.4872-1-krzk@kernel.org>
References: <20180725155517.4872-1-krzk@kernel.org>
Message-ID: <20180725155517.4872-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bindings for s2mps11/s5m8767 clocks driver require a compatible for
clocks node.  Parent MFD sec-core driver will also use it when
instantiating children.

The compatible is not needed for proper working because device will be
anyway created by parent MFD device.  Add it for correctness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 1 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts     | 1 +
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index cdda614e417e..3447160e1fbf 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -89,6 +89,7 @@
 		pinctrl-0 = <&s2mps11_irq>;
 
 		s2mps11_osc: clocks {
+			compatible = "samsung,s2mps11-clk";
 			#clock-cells = <1>;
 			clock-output-names = "s2mps11_ap",
 					"s2mps11_cp", "s2mps11_bt";
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 831c7336f237..3cf905047893 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -141,6 +141,7 @@
 		reg = <0x66>;
 
 		s2mps11_osc: clocks {
+			compatible = "samsung,s2mps11-clk";
 			#clock-cells = <1>;
 			clock-output-names = "s2mps11_ap",
 					"s2mps11_cp", "s2mps11_bt";
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 2f4f40882dab..a368c73a1e48 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -141,6 +141,7 @@
 		pinctrl-0 = <&s2mps11_irq>;
 
 		s2mps11_osc: clocks {
+			compatible = "samsung,s2mps11-clk";
 			#clock-cells = <1>;
 			clock-output-names = "s2mps11_ap",
 					"s2mps11_cp", "s2mps11_bt";
-- 
2.14.1
