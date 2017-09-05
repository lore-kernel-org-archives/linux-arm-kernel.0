From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue,  5 Sep 2017 19:09:55 +0200
Subject: [PATCH] ARM64: dts: meson-gxl-libretech-cc: enable saradc
Message-ID: <20170905170955.13135-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable saradc and add the reference 1.8v regulator required.
The libretech-cc has saradc channel 0 and 2 available on the 2 first
pins of 2J3 header

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 69ca14ac10fa..71c3b3545bba 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -93,6 +93,13 @@
 			 <1800000 1>;
 	};
 
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	vddio_boot: regulator-vddio_boot {
 		compatible = "regulator-fixed";
 		regulator-name = "VDDIO_BOOT";
@@ -193,6 +200,11 @@
 			  "7J1 Header Pin15";
 };
 
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao18>;
+};
+
 /* SD card */
 &sd_emmc_b {
 	status = "okay";
-- 
2.9.5
