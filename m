From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sat, 24 Dec 2016 07:43:54 +0200
Subject: [PATCH] ARM: dts: imx: remove obsoleted property fsl,
 spi-num-chipselects
Message-ID: <20161224054354.28289-1-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit b36581df7e78 ("spi: imx: Using existing properties for
chipselects") the device tree property 'fsl,spi-num-chipselects' is
unused and it is already marked as obsolete in device tree binding
documentation. Remove the property from the existing DTS files to
avoid its reoccurence on copying.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/imx1-ads.dts                         | 1 -
 arch/arm/boot/dts/imx27-apf27dev.dts                   | 2 --
 arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts | 1 -
 arch/arm/boot/dts/imx27-pdk.dts                        | 1 -
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi      | 1 -
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts         | 1 -
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi        | 1 -
 arch/arm/boot/dts/imx50-evk.dts                        | 1 -
 arch/arm/boot/dts/imx51-apf51dev.dts                   | 2 --
 arch/arm/boot/dts/imx51-babbage.dts                    | 1 -
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi      | 1 -
 arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts | 1 -
 arch/arm/boot/dts/imx53-smd.dts                        | 1 -
 arch/arm/boot/dts/imx53-tqma53.dtsi                    | 2 --
 arch/arm/boot/dts/imx53-tx53.dtsi                      | 1 -
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi            | 1 -
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts            | 1 -
 arch/arm/boot/dts/imx6q-ba16.dtsi                      | 1 -
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                    | 1 -
 arch/arm/boot/dts/imx6q-cm-fx6.dts                     | 1 -
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts                | 1 -
 arch/arm/boot/dts/imx6q-evi.dts                        | 3 ---
 arch/arm/boot/dts/imx6q-gw5400-a.dts                   | 1 -
 arch/arm/boot/dts/imx6q-marsboard.dts                  | 1 -
 arch/arm/boot/dts/imx6q-novena.dts                     | 1 -
 arch/arm/boot/dts/imx6qdl-apalis.dtsi                  | 2 --
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi                 | 1 -
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi            | 1 -
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi           | 3 ---
 arch/arm/boot/dts/imx6qdl-colibri.dtsi                 | 1 -
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi           | 1 -
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi                  | 1 -
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi               | 1 -
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi           | 1 -
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi          | 1 -
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi              | 1 -
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi           | 1 -
 arch/arm/boot/dts/imx6qdl-rex.dtsi                     | 2 --
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi               | 1 -
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi               | 1 -
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi                 | 1 -
 arch/arm/boot/dts/imx6qdl-ts4900.dtsi                  | 2 --
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                     | 1 -
 arch/arm/boot/dts/imx6sl-evk.dts                       | 1 -
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts               | 1 -
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                    | 1 -
 arch/arm/boot/dts/imx7d-sdb.dts                        | 1 -
 47 files changed, 57 deletions(-)

diff --git a/arch/arm/boot/dts/imx1-ads.dts b/arch/arm/boot/dts/imx1-ads.dts
index f504986..5ea28ee 100644
--- a/arch/arm/boot/dts/imx1-ads.dts
+++ b/arch/arm/boot/dts/imx1-ads.dts
@@ -38,7 +38,6 @@
 
 &cspi1 {
 	pinctrl-0 = <&pinctrl_cspi1>;
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index bba3f41..5f84b59 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -77,7 +77,6 @@
 };
 
 &cspi1 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_cspi1 &pinctrl_cspi1_cs>;
@@ -95,7 +94,6 @@
 };
 
 &cspi2 {
-	fsl,spi-num-chipselects = <3>;
 	cs-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>,
 		   <&gpio4 27 GPIO_ACTIVE_LOW>,
 		   <&gpio2 17 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
index 27846ff..f565357 100644
--- a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
+++ b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
@@ -81,7 +81,6 @@
 
 &cspi1 {
 	pinctrl-0 = <&pinctrl_cspi1>;
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index d0ef496..96f442b 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -37,7 +37,6 @@
 &cspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_cspi2>;
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 21 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
index 1b62480..4f3e0f4 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
@@ -23,7 +23,6 @@
 };
 
 &cspi1 {
-	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>,
 		   <&gpio4 27 GPIO_ACTIVE_HIGH>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index cf09e72..2a9198f 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -69,7 +69,6 @@
 
 &cspi1 {
 	pinctrl-0 = <&pinctrl_cspi1>, <&pinctrl_cspi1cs1>;
-	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>,
 		   <&gpio4 27 GPIO_ACTIVE_LOW>;
 };
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index b4e955e..82fec93 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -75,7 +75,6 @@
 &cspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_cspi1>;
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx50-evk.dts b/arch/arm/boot/dts/imx50-evk.dts
index 27d763c..dba2d95 100644
--- a/arch/arm/boot/dts/imx50-evk.dts
+++ b/arch/arm/boot/dts/imx50-evk.dts
@@ -26,7 +26,6 @@
 &cspi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_cspi>;
-	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <&gpio4 11 0>, <&gpio4 13 0>;
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
index 0f3fe29..a5e6091 100644
--- a/arch/arm/boot/dts/imx51-apf51dev.dts
+++ b/arch/arm/boot/dts/imx51-apf51dev.dts
@@ -80,7 +80,6 @@
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
-	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>,
 		   <&gpio4 25 GPIO_ACTIVE_HIGH>;
 	status = "okay";
@@ -89,7 +88,6 @@
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi2>;
-	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <&gpio3 28 GPIO_ACTIVE_LOW>,
 		   <&gpio3 27 GPIO_ACTIVE_LOW>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index f097b4f..873cf24 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -178,7 +178,6 @@
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
-	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>,
 		   <&gpio4 25 GPIO_ACTIVE_LOW>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
index 16fc69c..b821066 100644
--- a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
+++ b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
@@ -24,7 +24,6 @@
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index 7282128..1305b05 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -114,7 +114,6 @@
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 9f51900..472f6f0 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -63,7 +63,6 @@
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
-	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>;
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index 91a6a9f..85972f2 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -55,7 +55,6 @@
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
-	fsl,spi-num-chipselects = <4>;
 	cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>,
 		   <&gpio3 24 0>, <&gpio3 25 0>;
 	status = "disabled";
@@ -249,7 +248,6 @@
 &cspi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_cspi>;
-	fsl,spi-num-chipselects = <3>;
 	cs-gpios = <&gpio1 18 0>, <&gpio1 19 0>,
 		   <&gpio1 21 0>;
 	status = "disabled";
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 57e75f1..3a32201 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -161,7 +161,6 @@
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
-	fsl,spi-num-chipselects = <2>;
 	status = "okay";
 
 	cs-gpios = <
diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
index ba689fb..524192c 100644
--- a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
+++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
@@ -129,7 +129,6 @@
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
-	fsl,spi-num-chipselects = <4>;
 	cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>, <&gpio2 16 0>, <&gpio2 17 0>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
index d4c4a22..32a812b 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
@@ -66,7 +66,6 @@
 };
 
 &ecspi2 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi2>;
diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index 308e11c..3577aa7 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -133,7 +133,6 @@
 };
 
 &ecspi1 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index e4a415f..b1be794 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -95,7 +95,6 @@
 };
 
 &ecspi5 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi5>;
diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index a150bca..ae90d98 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -114,7 +114,6 @@
 };
 
 &ecspi1 {
-	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>, <&gpio3 19 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index 908dab6..f28883b 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -104,7 +104,6 @@
 &ecspi5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi5>;
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio1 12 0>;
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
index 7c7c1a8..fd2220a 100644
--- a/arch/arm/boot/dts/imx6q-evi.dts
+++ b/arch/arm/boot/dts/imx6q-evi.dts
@@ -90,7 +90,6 @@
 };
 
 &ecspi1 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1cs>;
@@ -98,7 +97,6 @@
 };
 
 &ecspi3 {
-	fsl,spi-num-chipselects = <3>;
 	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>,
 		<&gpio4 25 GPIO_ACTIVE_LOW>,
 		<&gpio4 26 GPIO_ACTIVE_LOW>;
@@ -108,7 +106,6 @@
 };
 
 &ecspi5 {
-	fsl,spi-num-chipselects = <4>;
 	cs-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>,
 		<&gpio1 13 GPIO_ACTIVE_LOW>,
 		<&gpio1 12 GPIO_ACTIVE_LOW>,
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 747bc10..8e84713 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -138,7 +138,6 @@
 };
 
 &ecspi1 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
diff --git a/arch/arm/boot/dts/imx6q-marsboard.dts b/arch/arm/boot/dts/imx6q-marsboard.dts
index f7995c5..51220a3 100644
--- a/arch/arm/boot/dts/imx6q-marsboard.dts
+++ b/arch/arm/boot/dts/imx6q-marsboard.dts
@@ -97,7 +97,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
 	cs-gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;
-	fsl,spi-num-chipselects = <1>;
 	status = "okay";
 
 	m25p80 at 0 {
diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index 758bca9..0fa32b2 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -210,7 +210,6 @@
 &ecspi3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi3_novena>;
-	fsl,spi-num-chipselects = <3>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 8c8a049..82652c1 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -175,7 +175,6 @@
 
 /* Apalis SPI1 */
 &ecspi1 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio5 25 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
@@ -184,7 +183,6 @@
 
 /* Apalis SPI2 */
 &ecspi2 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio2 26 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi2>;
diff --git a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
index 5e7792d..550e100 100644
--- a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
@@ -176,7 +176,6 @@
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
-	fsl,spi-num-chipselects = <3>;
 	cs-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>,
 		   <&gpio4 10 GPIO_ACTIVE_LOW>,
 		   <&gpio4 11 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
index 54f4f01..b2debc0 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
@@ -100,7 +100,6 @@
 };
 
 &ecspi4 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 20 0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi4>;
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
index 7fff02c..0d9e96d 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
@@ -114,7 +114,6 @@
 };
 
 &ecspi1 {
-	fsl,spi-num-chipselects = <3>;
 	cs-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH
 		    &gpio4 10 GPIO_ACTIVE_HIGH
 		    &gpio4 11 GPIO_ACTIVE_HIGH>;
@@ -124,7 +123,6 @@
 };
 
 &ecspi2 {
-	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <&gpio2 26 GPIO_ACTIVE_HIGH &gpio2 27 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi2>;
@@ -132,7 +130,6 @@
 };
 
 &ecspi4 {
-	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH &gpio5 2 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi4>;
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index e6faa65..dbad481 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -138,7 +138,6 @@
 
 /* Colibri SSP */
 &ecspi4 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi4>;
diff --git a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
index b2c083d..d78312c 100644
--- a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
@@ -29,7 +29,6 @@
 };
 
 &ecspi3 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 24 0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi3>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 54aca3a..ab34f15 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -159,7 +159,6 @@
 };
 
 &ecspi3 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi3>;
diff --git a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
index 63acd54..e19f3c3 100644
--- a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
@@ -209,7 +209,6 @@
 };
 
 &ecspi1 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index 34887a1..e46c914 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -353,7 +353,6 @@
 };
 
 &ecspi1 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
index d80f21a..678ab19 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
@@ -284,7 +284,6 @@
 };
 
 &ecspi1 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index e476d01..c4d28e9 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -255,7 +255,6 @@
 };
 
 &ecspi1 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 19 0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index e9801a2..6e5cb6a 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -76,7 +76,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi3>;
 	status = "okay";
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 24 0>;
 
 	flash at 0 {
diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi b/arch/arm/boot/dts/imx6qdl-rex.dtsi
index 17704a5..5cf90c24 100644
--- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
@@ -89,7 +89,6 @@
 };
 
 &ecspi2 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi2>;
@@ -97,7 +96,6 @@
 };
 
 &ecspi3 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi3>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 52390ba..a2a714d 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -124,7 +124,6 @@
 };
 
 &ecspi1 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 19 0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 1f9076e..b0fa0c8 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -241,7 +241,6 @@
 };
 
 &ecspi1 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 19 0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 55ef535..63bf95e 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -160,7 +160,6 @@
 };
 
 &ecspi1 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 9 0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
diff --git a/arch/arm/boot/dts/imx6qdl-ts4900.dtsi b/arch/arm/boot/dts/imx6qdl-ts4900.dtsi
index 5c26b26..bf17ad5 100644
--- a/arch/arm/boot/dts/imx6qdl-ts4900.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-ts4900.dtsi
@@ -95,7 +95,6 @@
 };
 
 &ecspi1 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
@@ -109,7 +108,6 @@
 };
 
 &ecspi2 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi2>;
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index 2bf2e62..1691714 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -221,7 +221,6 @@
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
-	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <
 		&gpio2 30 GPIO_ACTIVE_HIGH
 		&gpio3 19 GPIO_ACTIVE_HIGH
diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index be11882..0a90eea 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -117,7 +117,6 @@
 };
 
 &ecspi1 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 11 0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
diff --git a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
index 9b817f3..b54b40a 100644
--- a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
+++ b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
@@ -142,7 +142,6 @@
 };
 
 &ecspi1 {
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio2 16 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index 530e9ca..c784a0b 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -285,7 +285,6 @@
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi2>;
-	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <
 		&gpio1 29 GPIO_ACTIVE_HIGH
 		&gpio1 10 GPIO_ACTIVE_HIGH
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 2f33c46..9d15273 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -111,7 +111,6 @@
 };
 
 &ecspi3 {
-	fsl,spi-num-chipselects = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi3>;
 	cs-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
-- 
2.10.2
