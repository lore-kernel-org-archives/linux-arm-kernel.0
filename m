From: linux.amoon@gmail.com (Anand Moon)
Date: Thu, 18 Jun 2015 21:26:03 +0930
Subject: [PATCH] ARM: dts: exynos5422-odroidxu3: Add ramp delay for regulators
Message-ID: <1434628563-3477-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds ramp delay for the vdd_ldo9, vdd_ldo13,
vdd_ldo15 and vdd_sd regulator. Changes removes
warning "ramp_delay not set" for all the above regulator.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes based on https://github.com/krzk/linux.git branch dt-for-next
Console message:
[    3.756440] vdd_ldo9: ramp_delay not set
[    3.767731] vdd_ldo13: ramp_delay not set
[    3.775260] vdd_ldo15: ramp_delay not set
[    3.786269] vdd_sd: ramp_delay not set
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 1565667..7c97740 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -218,6 +218,8 @@
 				regulator-name = "vdd_ldo9";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-ramp-delay = <8000>;
 				regulator-always-on;
 			};
 
@@ -246,6 +248,8 @@
 				regulator-name = "vdd_ldo13";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-ramp-delay = <8000>;
 				regulator-always-on;
 			};
 
@@ -253,6 +257,8 @@
 				regulator-name = "vdd_ldo15";
 				regulator-min-microvolt = <3100000>;
 				regulator-max-microvolt = <3100000>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-ramp-delay = <8000>;
 				regulator-always-on;
 			};
 
@@ -274,6 +280,8 @@
 				regulator-name = "vdd_sd";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-ramp-delay = <8000>;
 				regulator-always-on;
 			};
 
-- 
2.4.4
