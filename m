From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 19 May 2016 17:52:33 -0400
Subject: [PATCH] ARM: dts: exynos: Remove unneded always-on for regulators on
 Peach boards
Message-ID: <1463694753-7259-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulator always-on property should only be used for regulators
that either can't be disabled or the drivers for the client devices
are not enabling the regulator and so being disabled due to unused.

There are some max77802 regulators in the Peach Pit and Pi boards
that are always-on but shouldn't since they are enabled by drivers:

BUCK5 is max77802 inl1 supply
BUCK7 is max77802 inl{2,10} supply
BUCK9 is max77802 inl{3,4,5,7} supply
BUCK10 is mmc1 vqmmc supply
LDO9 is adc vdd supply

This patch removes the always-on property for these regulators.

Some regulators should remain always-on even when they are used as
input supplies, because these regulators are also used by other
components that are not described in the DT, for example:

LDO10 is hdmi vdd_osc supply but it's also used as input supply for
the Exynos5420 temperature sensor.

LDO8 is hdmi vdd and vdd_pll supply but it's also used as supply for
the Exynos5420 Display port.

BUCK2 and BUCK6 are the vdd supplies for the EAGLE and KFC clusters.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 5 -----
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index f9d2e4f1a0e0..c1247402cb17 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -278,7 +278,6 @@
 				regulator-name = "vdd_1v2";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
-				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
 					regulator-off-in-suspend;
@@ -301,7 +300,6 @@
 				regulator-name = "vdd_1v35";
 				regulator-min-microvolt = <1350000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -323,7 +321,6 @@
 				regulator-name = "vdd_2v";
 				regulator-min-microvolt = <2000000>;
 				regulator-max-microvolt = <2000000>;
-				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -334,7 +331,6 @@
 				regulator-name = "vdd_1v8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -419,7 +415,6 @@
 				regulator-name = "vdd_ldo9";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
 				regulator-state-mem {
 					regulator-on-in-suspend;
 					regulator-mode = <MAX77802_OPMODE_LP>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 62ceb89e073f..af1c9b9a63f9 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -278,7 +278,6 @@
 				regulator-name = "vdd_1v2";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
-				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
 					regulator-off-in-suspend;
@@ -301,7 +300,6 @@
 				regulator-name = "vdd_1v35";
 				regulator-min-microvolt = <1350000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -323,7 +321,6 @@
 				regulator-name = "vdd_2v";
 				regulator-min-microvolt = <2000000>;
 				regulator-max-microvolt = <2000000>;
-				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -334,7 +331,6 @@
 				regulator-name = "vdd_1v8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -419,7 +415,6 @@
 				regulator-name = "vdd_ldo9";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
 				regulator-state-mem {
 					regulator-on-in-suspend;
 					regulator-mode = <MAX77802_OPMODE_LP>;
-- 
2.5.5
