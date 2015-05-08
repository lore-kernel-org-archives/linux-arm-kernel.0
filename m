From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Fri,  8 May 2015 08:21:05 +0200
Subject: [PATCH] ARM: dts: imx: add "nor-jedec" flash compatible binding
Message-ID: <1431066065-19644-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Starting with commits
8ff16cf ("Documentation: devicetree: m25p80: add "nor-jedec" binding")
1103b85 ("mtd: m25p80: bind to "nor-jedec" ID, for auto-detection")
we have "nor-jedec" binding indicating support for JEDEC identification.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/imx28-evk.dts              | 2 +-
 arch/arm/boot/dts/imx28-m28evk.dts           | 2 +-
 arch/arm/boot/dts/imx28-sps1.dts             | 2 +-
 arch/arm/boot/dts/imx50-evk.dts              | 2 +-
 arch/arm/boot/dts/imx53-smd.dts              | 2 +-
 arch/arm/boot/dts/imx6dl-rex-basic.dts       | 2 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts      | 2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts         | 2 +-
 arch/arm/boot/dts/imx6q-rex-pro.dts          | 2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi  | 2 +-
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi    | 2 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi     | 2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi     | 2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi       | 2 +-
 arch/arm/boot/dts/imx6sl-evk.dts             | 2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 279249b..5fa7c16 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -57,7 +57,7 @@
 				flash: m25p80 at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "sst,sst25vf016b";
+					compatible = "sst,sst25vf016b", "nor-jedec";
 					spi-max-frequency = <40000000>;
 					reg = <0>;
 				};
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index e35cc6b..c7c05d5 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -41,7 +41,7 @@
 				flash: m25p80 at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "m25p80";
+					compatible = "m25p80", "nor-jedec";
 					spi-max-frequency = <40000000>;
 					reg = <0>;
 				};
diff --git a/arch/arm/boot/dts/imx28-sps1.dts b/arch/arm/boot/dts/imx28-sps1.dts
index 0ce3cb8..57c8cf7 100644
--- a/arch/arm/boot/dts/imx28-sps1.dts
+++ b/arch/arm/boot/dts/imx28-sps1.dts
@@ -59,7 +59,7 @@
 				flash: m25p80 at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "everspin,mr25h256", "mr25h256";
+					compatible = "everspin,mr25h256", "mr25h256", "nor-jedec";
 					spi-max-frequency = <40000000>;
 					reg = <0>;
 				};
diff --git a/arch/arm/boot/dts/imx50-evk.dts b/arch/arm/boot/dts/imx50-evk.dts
index 1b22512..0ce50f4 100644
--- a/arch/arm/boot/dts/imx50-evk.dts
+++ b/arch/arm/boot/dts/imx50-evk.dts
@@ -33,7 +33,7 @@
 	flash: m25p32 at 1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "m25p32", "m25p80";
+		compatible = "m25p32", "nor-jedec";
 		spi-max-frequency = <25000000>;
 		reg = <1>;
 
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 1d32557..6c32d4d 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -76,7 +76,7 @@
 	flash: m25p32 at 1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "st,m25p32", "st,m25p";
+		compatible = "st,m25p32", "st,m25p", "nor-jedec";
 		spi-max-frequency = <20000000>;
 		reg = <1>;
 
diff --git a/arch/arm/boot/dts/imx6dl-rex-basic.dts b/arch/arm/boot/dts/imx6dl-rex-basic.dts
index b13845c..9dbfcc9 100644
--- a/arch/arm/boot/dts/imx6dl-rex-basic.dts
+++ b/arch/arm/boot/dts/imx6dl-rex-basic.dts
@@ -23,7 +23,7 @@
 
 &ecspi3 {
 	flash: m25p80 at 0 {
-		compatible = "sst,sst25vf016b";
+		compatible = "sst,sst25vf016b", "nor-jedec";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index 4fa2543..b58ed2a 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -109,7 +109,7 @@
 	status = "okay";
 
 	flash: m25p80 at 0 {
-		compatible = "m25p80";
+		compatible = "m25p80", "nor-jedec";
 		spi-max-frequency = <40000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 822ffb2..83b919c 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -145,7 +145,7 @@
 	status = "okay";
 
 	flash: m25p80 at 0 {
-		compatible = "sst,w25q256";
+		compatible = "sst,w25q256", "nor-jedec";
 		spi-max-frequency = <30000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6q-rex-pro.dts b/arch/arm/boot/dts/imx6q-rex-pro.dts
index 3c2852b..66e7a3a 100644
--- a/arch/arm/boot/dts/imx6q-rex-pro.dts
+++ b/arch/arm/boot/dts/imx6q-rex-pro.dts
@@ -23,7 +23,7 @@
 
 &ecspi3 {
 	flash: m25p80 at 0 {
-		compatible = "sst,sst25vf032b";
+		compatible = "sst,sst25vf032b", "nor-jedec";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
index e6d9195..6dc59d0 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
@@ -109,7 +109,7 @@
 	flash: m25p80 at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "micron,n25q128a11";
+		compatible = "micron,n25q128a11", "nor-jedec";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
index 2c253d6..a0952ca 100644
--- a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
@@ -36,7 +36,7 @@
 	flash: m25p80 at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "sst,sst25vf040b", "m25p80";
+		compatible = "sst,sst25vf040b", "nor-jedec";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 0821812..fd096dc 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -146,7 +146,7 @@
 	status = "okay";
 
 	flash: m25p80 at 0 {
-		compatible = "sst,sst25vf016b";
+		compatible = "sst,sst25vf016b", "nor-jedec";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 19cc269..f3bdf03 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -78,7 +78,7 @@
 	cs-gpios = <&gpio4 24 0>;
 
 	flash at 0 {
-		compatible = "m25p80";
+		compatible = "m25p80", "nor-jedec";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 009abd6..8bbcce2 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -55,7 +55,7 @@
 	flash: m25p80 at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "st,m25p32";
+		compatible = "st,m25p32", "nor-jedec";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 0b28a9d..483856e2 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -145,7 +145,7 @@
 	status = "okay";
 
 	flash: m25p80 at 0 {
-		compatible = "sst,sst25vf016b";
+		compatible = "sst,sst25vf016b", "nor-jedec";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index a626e6d..0c13b01 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -151,7 +151,7 @@
 	flash: m25p80 at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "st,m25p32";
+		compatible = "st,m25p32", "nor-jedec";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 945887d..3cc5d4a 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -126,7 +126,7 @@
 	flash: m25p80 at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "st,m25p32";
+		compatible = "st,m25p32", "nor-jedec";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
-- 
1.8.4.5
