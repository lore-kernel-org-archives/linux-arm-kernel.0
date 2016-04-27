From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 27 Apr 2016 14:19:11 +0200
Subject: [PATCH 1/3] ARM: dts: exynos: Define vqmmc for SD card and allow
 disabling regulators on Odroid X/X2/U3
Message-ID: <1461759553-10119-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SD-card vmmc-supply contained incorrectly two regulators. The second
one is ignored. Fix this by defining proper vmmc and vqmmc supplies.
Additionally these regulators do not have to be always on, so allow
disabling them to reduce energy consumption.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index cab0f07d7d28..3d0d44581fbd 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -249,7 +249,6 @@
 				regulator-name = "VDDQ_MMC2_2.8V";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
-				regulator-always-on;
 				regulator-boot-on;
 			};
 
@@ -345,7 +344,6 @@
 				regulator-name = "LDO21_3.3V";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
 				regulator-boot-on;
 			};
 
@@ -482,7 +480,8 @@
 	bus-width = <4>;
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 	pinctrl-names = "default";
-	vmmc-supply = <&ldo4_reg &ldo21_reg>;
+	vmmc-supply = <&ldo21_reg>;
+	vqmmc-supply = <&ldo4_reg>;
 	cd-gpios = <&gpk2 2 GPIO_ACTIVE_HIGH>;
 	cd-inverted;
 	status = "okay";
-- 
1.9.1
