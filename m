From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 31 May 2016 17:48:00 -0400
Subject: [PATCH] ARM: dts: exynos: Add TMU nodes regulator supply for Peach
 boards
Message-ID: <1464731280-24588-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos5800 Peach Pi and Exynos5420 Peach Pit Chromebooks have the
LDO10 1.8V output connected to the VDD18_TS{01,23,4} Exynos SoC pins.

Add this regulator as the input supply of the Thermal Management Unit
channels and also remove the always-on property since all the devices
using LDO10 as input supply are now defined.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 21 ++++++++++++++++++++-
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 21 ++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index c1247402cb17..a55760b5fa82 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -425,7 +425,6 @@
 				regulator-name = "vdd_ldo10";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -924,6 +923,26 @@
 	assigned-clock-parents = <&clock CLK_FIN_PLL>;
 };
 
+&tmu_cpu0 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&tmu_cpu1 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&tmu_cpu2 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&tmu_cpu3 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&tmu_gpu {
+	vtmu-supply = <&ldo10_reg>;
+};
+
 &rtc {
 	status = "okay";
 	clocks = <&clock CLK_RTC>, <&max77802 MAX77802_CLK_32K_AP>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index af1c9b9a63f9..34cc6cee0cdb 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -425,7 +425,6 @@
 				regulator-name = "vdd_ldo10";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -900,6 +899,26 @@
 	assigned-clock-parents = <&clock CLK_FIN_PLL>;
 };
 
+&tmu_cpu0 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&tmu_cpu1 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&tmu_cpu2 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&tmu_cpu3 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&tmu_gpu {
+	vtmu-supply = <&ldo10_reg>;
+};
+
 &rtc {
 	status = "okay";
 	clocks = <&clock CLK_RTC>, <&max77802 MAX77802_CLK_32K_AP>;
-- 
2.5.5
