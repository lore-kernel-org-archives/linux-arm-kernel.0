From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 13 Apr 2015 19:47:00 +0200
Subject: [PATCH 2/4] ARM: dts: Exynos5250: add CPU OPP and regulator supply
 property
In-Reply-To: <1428947223-17268-1-git-send-email-b.zolnierkie@samsung.com>
References: <1428947223-17268-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1428947223-17268-3-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

For Exynos5250 platforms, add CPU operating points and CPU
regulator supply properties for migrating from Exynos specific
cpufreq driver to using generic cpufreq driver.

Changes by Bartlomiej:
- split Exynos5250 support from the original patch
- added CPU regulator supply property for Google Spring board

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Andreas Farber <afaerber@suse.de>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5250-arndale.dts  |    4 ++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts |    4 ++++
 arch/arm/boot/dts/exynos5250-snow.dts     |    4 ++++
 arch/arm/boot/dts/exynos5250-spring.dts   |    4 ++++
 arch/arm/boot/dts/exynos5250.dtsi         |   22 ++++++++++++++++++++++
 5 files changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 7e728a1..c64cec3 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -560,3 +560,7 @@
 	status = "okay";
 	samsung,exynos-sataphy-i2c-phandle = <&sata_phy_i2c>;
 };
+
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index bc27cc2..d91db82 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -410,3 +410,7 @@
 		};
 	};
 };
+
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 2657e84..700bbc8 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -301,6 +301,10 @@
 	vdd_pll-supply = <&ldo8_reg>;
 };
 
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
+
 &i2c_0 {
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index d03f9b8..38b54d9 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -99,6 +99,10 @@
 	vdd_pll-supply = <&ldo8_reg>;
 };
 
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
+
 &i2c_0 {
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 257e2f1..c1f7811 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -63,6 +63,28 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1700000000>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+			clock-latency = <140000>;
+
+			operating-points = <
+				1700000 1300000
+				1600000 1250000
+				1500000 1225000
+				1400000 1200000
+				1300000 1150000
+				1200000 1125000
+				1100000 1100000
+				1000000 1075000
+				 900000 1050000
+				 800000 1025000
+				 700000 1012500
+				 600000 1000000
+				 500000  975000
+				 400000  950000
+				 300000  937500
+				 200000  925000
+			>;
 			cooling-min-level = <15>;
 			cooling-max-level = <9>;
 			#cooling-cells = <2>; /* min followed by max */
-- 
1.7.9.5
