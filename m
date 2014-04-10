From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 10 Apr 2014 14:20:51 +0200
Subject: [PATCH V3 08/19] ARM: ux500: Convert to the common mmc DT bindings
 for highspeed mode
In-Reply-To: <1397132462-8005-1-git-send-email-ulf.hansson@linaro.org>
References: <1397132462-8005-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1397132462-8005-9-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmci host driver supports the common mmc DT parser, which enables
us to use the use common names instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
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
index 46dce42..3f07c58 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -116,8 +116,8 @@
 			arm,primecell-periphid = <0x10480180>;
 			max-frequency = <100000000>;
 			bus-width = <4>;
-			mmc-cap-sd-highspeed;
-			mmc-cap-mmc-highspeed;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
 			st,sig-dir-dat0;
 			st,sig-dir-dat2;
 			st,sig-dir-cmd;
@@ -148,7 +148,7 @@
 			arm,primecell-periphid = <0x10480180>;
 			max-frequency = <100000000>;
 			bus-width = <8>;
-			mmc-cap-mmc-highspeed;
+			cap-mmc-highspeed;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdi2_default_mode>;
 			pinctrl-1 = <&sdi2_sleep_mode>;
@@ -161,7 +161,7 @@
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
