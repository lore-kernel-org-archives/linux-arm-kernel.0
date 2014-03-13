From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 13 Mar 2014 13:32:43 +0100
Subject: [PATCH] ARM: mach-ux500|nomadik|u300: Align to common DT bindings for
 mmci
Message-ID: <1394713963-18300-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the first step in preparing the mmci driver for converting to the
mmc_of_parse API, let's align to the common names of DT bindings for
the mmc/sd highspeed modes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmci.txt |    4 ----
 arch/arm/boot/dts/ste-ccu9540.dts              |    6 +++---
 arch/arm/boot/dts/ste-href.dtsi                |    8 ++++----
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi     |    4 ++--
 arch/arm/boot/dts/ste-snowball.dts             |    4 ++--
 arch/arm/boot/dts/ste-u300.dts                 |    4 ++--
 drivers/mmc/host/mmci.c                        |    4 ++--
 7 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
index 2b584ca..0c463e0 100644
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -9,7 +9,3 @@ by mmc.txt and the properties used by the mmci driver.
 Required properties:
 - compatible             : contains "arm,pl18x", "arm,primecell".
 - arm,primecell-periphid : contains the PrimeCell Peripheral ID.
-
-Optional properties:
-- mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable
-- mmc-cap-sd-highspeed   : indicates whether SD is high speed capable
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
index 6cb9b68..a5db487 100644
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
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 			vqmmc-supply = <&vmmci>;
 			pinctrl-names = "default", "sleep";
@@ -144,7 +144,7 @@
 			arm,primecell-periphid = <0x10480180>;
 			max-frequency = <100000000>;
 			bus-width = <8>;
-			mmc-cap-mmc-highspeed;
+			cap-mmc-highspeed;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdi2_default_mode>;
 			pinctrl-1 = <&sdi2_sleep_mode>;
@@ -157,7 +157,7 @@
 			arm,primecell-periphid = <0x10480180>;
 		        max-frequency = <100000000>;
 			bus-width = <8>;
-			mmc-cap-mmc-highspeed;
+			cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux2_reg>;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdi4_default_mode>;
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 5acc044..d316c95 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -840,8 +840,8 @@
 			interrupts = <22>;
 			max-frequency = <48000000>;
 			bus-width = <4>;
-			mmc-cap-mmc-highspeed;
-			mmc-cap-sd-highspeed;
+			cap-mmc-highspeed;
+			cap-sd-highspeed;
 			cd-gpios = <&gpio3 15 0x1>;
 			cd-inverted;
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 97d5d21..4add51f 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -155,7 +155,7 @@
 			arm,primecell-periphid = <0x10480180>;
 			max-frequency = <100000000>;
 			bus-width = <4>;
-			mmc-cap-mmc-highspeed;
+			cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 			vqmmc-supply = <&vmmci>;
 			pinctrl-names = "default", "sleep";
@@ -194,7 +194,7 @@
 			arm,primecell-periphid = <0x10480180>;
 		        max-frequency = <100000000>;
 			bus-width = <8>;
-			mmc-cap-mmc-highspeed;
+			cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux2_reg>;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdi4_default_mode>;
diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index a9da480..0a839da 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -442,8 +442,8 @@
 			clock-names = "apb_pclk", "mclk";
 			max-frequency = <24000000>;
 			bus-width = <4>; // SD-card slot
-			mmc-cap-mmc-highspeed;
-			mmc-cap-sd-highspeed;
+			cap-mmc-highspeed;
+			cap-sd-highspeed;
 			cd-gpios = <&gpio 12 0x4>;
 			cd-inverted;
 			vmmc-supply = <&ab3100_ldo_g_reg>;
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b931226..c321bb6 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1395,9 +1395,9 @@ static void mmci_dt_populate_generic_pdata(struct device_node *np,
 	if (!pdata->f_max)
 		pr_warn("%s has no 'max-frequency' property\n", np->full_name);
 
-	if (of_get_property(np, "mmc-cap-mmc-highspeed", NULL))
+	if (of_get_property(np, "cap-mmc-highspeed", NULL))
 		pdata->capabilities |= MMC_CAP_MMC_HIGHSPEED;
-	if (of_get_property(np, "mmc-cap-sd-highspeed", NULL))
+	if (of_get_property(np, "cap-sd-highspeed", NULL))
 		pdata->capabilities |= MMC_CAP_SD_HIGHSPEED;
 
 	of_property_read_u32(np, "bus-width", &bus_width);
-- 
1.7.9.5
