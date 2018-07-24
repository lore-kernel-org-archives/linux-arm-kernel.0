From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 24 Jul 2018 14:52:25 +0200
Subject: [PATCH 01/14] arm64: dts: meson-axg: improve power supplies
 description
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Message-ID: <20180724125238.14567-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the parent supply of the s400 power supplies.
Also add 'regulator-always-on' property on the regulators which can't
be disabled

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index fd90fa4a282c..09c7909a78ea 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -65,6 +65,7 @@
 		regulator-name = "12V";
 		regulator-min-microvolt = <12000000>;
 		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
 	};
 
 	vddio_boot: regulator-vddio_boot {
@@ -72,6 +73,8 @@
 		regulator-name = "VDDIO_BOOT";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
 	};
 
 	vddao_3v3: regulator-vddao_3v3 {
@@ -79,6 +82,8 @@
 		regulator-name = "VDDAO_3V3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		vin-supply = <&main_12v>;
+		regulator-always-on;
 	};
 
 	vddio_ao18: regulator-vddio_ao18 {
@@ -86,6 +91,8 @@
 		regulator-name = "VDDIO_AO18";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
 	};
 
 	vcc_3v3: regulator-vcc_3v3 {
@@ -93,6 +100,8 @@
 		regulator-name = "VCC_3V3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
 	};
 
 	emmc_pwrseq: emmc-pwrseq {
-- 
2.17.1
