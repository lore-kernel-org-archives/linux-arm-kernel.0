From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Mar 2014 13:14:10 +0100
Subject: [PATCH 13/20] ARM: ux500: Add the mmc capabilities flags to DT
In-Reply-To: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1395404057-27835-14-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/ste-href.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index e830c37..be34beb 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -119,10 +119,13 @@
 			bus-width = <4>;
 			cap-sd-highspeed;
 			cap-mmc-highspeed;
+			full-pwr-cycle;
 			signal-direction = <(MCI_ST_DATA2DIREN |
 						MCI_ST_CMDDIREN |
 						MCI_ST_DATA0DIREN |
 						MCI_ST_FBCLKEN)>;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 			vqmmc-supply = <&vmmci>;
 			pinctrl-names = "default", "sleep";
@@ -137,6 +140,7 @@
 			arm,primecell-periphid = <0x10480180>;
 			max-frequency = <100000000>;
 			bus-width = <4>;
+			non-removable;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdi1_default_mode>;
 			pinctrl-1 = <&sdi1_sleep_mode>;
@@ -150,6 +154,7 @@
 			max-frequency = <100000000>;
 			bus-width = <8>;
 			cap-mmc-highspeed;
+			non-removable;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdi2_default_mode>;
 			pinctrl-1 = <&sdi2_sleep_mode>;
@@ -163,6 +168,7 @@
 		        max-frequency = <100000000>;
 			bus-width = <8>;
 			cap-mmc-highspeed;
+			non-removable;
 			vmmc-supply = <&ab8500_ldo_aux2_reg>;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdi4_default_mode>;
-- 
1.7.9.5
