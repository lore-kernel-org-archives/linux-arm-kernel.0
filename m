From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 12 Dec 2013 14:31:36 +0100
Subject: [PATCH 1/3] ARM: ux500: Refactor common DT configs for sdi[n] devices
In-Reply-To: <1386855098-14272-1-git-send-email-ulf.hansson@linaro.org>
References: <1386855098-14272-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1386855098-14272-2-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated configurations and move specific details into
each corresponding dtsi file for the href versions.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: devicetree at vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/ste-href.dtsi        |    2 --
 arch/arm/boot/dts/ste-hrefprev60.dtsi  |    5 ++++
 arch/arm/boot/dts/ste-hrefv60plus.dtsi |   39 --------------------------------
 3 files changed, 5 insertions(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index e282421..0c1e8d8 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -124,8 +124,6 @@
 			pinctrl-0 = <&sdi0_default_mode>;
 			pinctrl-1 = <&sdi0_sleep_mode>;
 
-			cd-gpios  = <&tc3589x_gpio 3 0x4>;
-
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index b0f5def..af9914e 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -60,6 +60,11 @@
 			pinctrl-0 = <&ssp0_hrefprev60_mode>;
 		};
 
+		// External Micro SD slot
+		sdi0_per1 at 80126000 {
+			cd-gpios  = <&tc3589x_gpio 3 0x4>;
+		};
+
 		vmmci: regulator-gpio {
 			gpios = <&tc3589x_gpio 18 0x4>;
 			enable-gpio = <&tc3589x_gpio 17 0x4>;
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index 941bf9a..1f7b46b 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -19,46 +19,7 @@
 	soc {
 		// External Micro SD slot
 		sdi0_per1 at 80126000 {
-			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <100000000>;
-			bus-width = <4>;
-			mmc-cap-sd-highspeed;
-			mmc-cap-mmc-highspeed;
-			vmmc-supply = <&ab8500_ldo_aux3_reg>;
-
 			cd-gpios  = <&gpio2 31 0x4>; // 95
-
-			status = "okay";
-		};
-
-		// WLAN SDIO channel
-		sdi1_per2 at 80118000 {
-			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <100000000>;
-			bus-width = <4>;
-
-			status = "okay";
-		};
-
-		// PoP:ed eMMC
-		sdi2_per3 at 80005000 {
-			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <100000000>;
-			bus-width = <8>;
-			mmc-cap-mmc-highspeed;
-
-			status = "okay";
-		};
-
-		// On-board eMMC
-		sdi4_per2 at 80114000 {
-			arm,primecell-periphid = <0x10480180>;
-		        max-frequency = <100000000>;
-			bus-width = <8>;
-			mmc-cap-mmc-highspeed;
-			vmmc-supply = <&ab8500_ldo_aux2_reg>;
-
-			status = "okay";
 		};
 
 		pinctrl {
-- 
1.7.9.5
