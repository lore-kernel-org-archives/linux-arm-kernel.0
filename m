From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Mar 2014 13:14:05 +0100
Subject: [PATCH 08/20] ARM: ux500: Convert to the common mmc DT bindings for
 highspeed mode
In-Reply-To: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1395404057-27835-9-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmci host driver supports the common mmc DT parser, which enables
us to use the use common names instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/ste-ccu9540.dts  |    6 +++---
 arch/arm/boot/dts/ste-href.dtsi    |    8 ++++----
 arch/arm/boot/dts/ste-snowball.dts |    4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/ste-ccu9540.dts b/arch/arm/boot/dts/ste-ccu9540.dts
index 2295087..651c56d 100644
--- a/arch/arm/boot/dts/ste-ccu9540.dts
+++ b/arch/arm/boot/dts/ste-ccu9540.dts
@@ -38,8 +38,8 @@
 			arm,primecell-periphid = <0x10480180>;
 			max-frequency = <100000000>;
 			bus-width = <4>;
-			mmc-cap-sd-highspeed;
-			mmc-cap-mmc-highspeed;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 
 			cd-gpios  = <&gpio7 6 0x4>; // 230
@@ -63,7 +63,7 @@
 			arm,primecell-periphid = <0x10480180>;
 		        max-frequency = <100000000>;
 			bus-width = <8>;
-			mmc-cap-mmc-highspeed;
+			cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux2_reg>;
 
 			status = "okay";
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index d50fe24..e830c37 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -117,8 +117,8 @@
 			arm,primecell-periphid = <0x10480180>;
 			max-frequency = <100000000>;
 			bus-width = <4>;
-			mmc-cap-sd-highspeed;
-			mmc-cap-mmc-highspeed;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
 			signal-direction = <(MCI_ST_DATA2DIREN |
 						MCI_ST_CMDDIREN |
 						MCI_ST_DATA0DIREN |
@@ -149,7 +149,7 @@
 			arm,primecell-periphid = <0x10480180>;
 			max-frequency = <100000000>;
 			bus-width = <8>;
-			mmc-cap-mmc-highspeed;
+			cap-mmc-highspeed;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdi2_default_mode>;
 			pinctrl-1 = <&sdi2_sleep_mode>;
@@ -162,7 +162,7 @@
 			arm,primecell-periphid = <0x10480180>;
 		        max-frequency = <100000000>;
 			bus-width = <8>;
-			mmc-cap-mmc-highspeed;
+			cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux2_reg>;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdi4_default_mode>;
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index a2f632d..474ef832 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -156,7 +156,7 @@
 			arm,primecell-periphid = <0x10480180>;
 			max-frequency = <100000000>;
 			bus-width = <4>;
-			mmc-cap-mmc-highspeed;
+			cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 			vqmmc-supply = <&vmmci>;
 			pinctrl-names = "default", "sleep";
@@ -195,7 +195,7 @@
 			arm,primecell-periphid = <0x10480180>;
 		        max-frequency = <100000000>;
 			bus-width = <8>;
-			mmc-cap-mmc-highspeed;
+			cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux2_reg>;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdi4_default_mode>;
-- 
1.7.9.5
