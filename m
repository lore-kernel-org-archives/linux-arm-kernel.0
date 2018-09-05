From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed,  5 Sep 2018 19:40:24 +0200
Subject: [RFT] ARM: dts: exynos: Remove double SD card detect pin inversion
Message-ID: <20180905174024.28366-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SDHCI standard, MMC host controller bindings and MMC core defines
card detect pin as active low.  Therefore there is no point to invert it
twice.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Tested only on Odroid U3. Tests on other platforms would be appreciated.
---
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 3 +--
 arch/arm/boot/dts/exynos4412-midas.dtsi         | 3 +--
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 4e6ff97e1ec4..249bfbff1e20 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -537,8 +537,7 @@
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4>;
 	pinctrl-names = "default";
 	vmmc-supply = <&ldo5_reg>;
-	cd-gpios = <&gpx3 4 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpx3 4 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index c0476c290977..aed2f2e2b0d1 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -1269,8 +1269,7 @@
 
 &sdhci_2 {
 	bus-width = <4>;
-	cd-gpios = <&gpx3 4 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpx3 4 GPIO_ACTIVE_LOW>;
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sdhci2_cd>;
 	pinctrl-names = "default";
 	vmmc-supply = <&ldo21_reg>;
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index a09e46c9dbc0..2caa3132f34e 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -539,8 +539,7 @@
 	pinctrl-names = "default";
 	vmmc-supply = <&ldo21_reg>;
 	vqmmc-supply = <&ldo4_reg>;
-	cd-gpios = <&gpk2 2 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpk2 2 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.14.1
