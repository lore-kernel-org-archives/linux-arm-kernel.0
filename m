From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 10 Apr 2014 14:20:56 +0200
Subject: [PATCH V3 13/19] ARM: ux500: Add the mmc capabilities flags to DT
In-Reply-To: <1397132462-8005-1-git-send-email-ulf.hansson@linaro.org>
References: <1397132462-8005-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1397132462-8005-14-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 3f07c58..48ea4c1 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -118,6 +118,9 @@
 			bus-width = <4>;
 			cap-sd-highspeed;
 			cap-mmc-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			full-pwr-cycle;
 			st,sig-dir-dat0;
 			st,sig-dir-dat2;
 			st,sig-dir-cmd;
@@ -136,6 +139,7 @@
 			arm,primecell-periphid = <0x10480180>;
 			max-frequency = <100000000>;
 			bus-width = <4>;
+			non-removable;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdi1_default_mode>;
 			pinctrl-1 = <&sdi1_sleep_mode>;
@@ -149,6 +153,7 @@
 			max-frequency = <100000000>;
 			bus-width = <8>;
 			cap-mmc-highspeed;
+			non-removable;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdi2_default_mode>;
 			pinctrl-1 = <&sdi2_sleep_mode>;
@@ -162,6 +167,7 @@
 		        max-frequency = <100000000>;
 			bus-width = <8>;
 			cap-mmc-highspeed;
+			non-removable;
 			vmmc-supply = <&ab8500_ldo_aux2_reg>;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdi4_default_mode>;
-- 
1.7.9.5
