From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 25 Sep 2015 15:51:32 +0200
Subject: [PATCH 2/2] ARM: u300: remove regulator-compatible usage
In-Reply-To: <1443189092-16430-1-git-send-email-javier@osg.samsung.com>
References: <1443189092-16430-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1443189092-16430-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulator-compatible property from the regulator DT binding was
deprecated and the correct approach is to use the node's name.

This patch has no functional changes since the values of the node's
name and the regulator-compatible match for all the regulators.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/ste-u300.dts | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 82a661677e97..9c73ac2842ad 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -315,21 +315,17 @@
 			ab3100-regulators {
 				compatible = "stericsson,ab3100-regulators";
 				ab3100_ldo_a_reg: ab3100_ldo_a {
-					regulator-compatible = "ab3100_ldo_a";
 					startup-delay-us = <200>;
 					regulator-always-on;
 					regulator-boot-on;
 				};
 				ab3100_ldo_c_reg: ab3100_ldo_c {
-					regulator-compatible = "ab3100_ldo_c";
 					startup-delay-us = <200>;
 				};
 				ab3100_ldo_d_reg: ab3100_ldo_d {
-					regulator-compatible = "ab3100_ldo_d";
 					startup-delay-us = <200>;
 				};
 				ab3100_ldo_e_reg: ab3100_ldo_e {
-					regulator-compatible = "ab3100_ldo_e";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 					startup-delay-us = <200>;
@@ -337,7 +333,6 @@
 					regulator-boot-on;
 				};
 				ab3100_ldo_f_reg: ab3100_ldo_f {
-					regulator-compatible = "ab3100_ldo_f";
 					regulator-min-microvolt = <2500000>;
 					regulator-max-microvolt = <2500000>;
 					startup-delay-us = <600>;
@@ -345,28 +340,23 @@
 					regulator-boot-on;
 				};
 				ab3100_ldo_g_reg: ab3100_ldo_g {
-					regulator-compatible = "ab3100_ldo_g";
 					regulator-min-microvolt = <1500000>;
 					regulator-max-microvolt = <2850000>;
 					startup-delay-us = <400>;
 				};
 				ab3100_ldo_h_reg: ab3100_ldo_h {
-					regulator-compatible = "ab3100_ldo_h";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <2750000>;
 					startup-delay-us = <200>;
 				};
 				ab3100_ldo_k_reg: ab3100_ldo_k {
-					regulator-compatible = "ab3100_ldo_k";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <2750000>;
 					startup-delay-us = <200>;
 				};
 				ab3100_ext_reg: ab3100_ext {
-					regulator-compatible = "ab3100_ext";
 				};
 				ab3100_buck_reg: ab3100_buck {
-					regulator-compatible = "ab3100_buck";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1800000>;
 					startup-delay-us = <1000>;
-- 
2.4.3
