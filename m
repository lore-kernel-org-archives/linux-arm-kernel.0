From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sun, 16 Aug 2015 08:39:17 +0200
Subject: [PATCH] ARM: dts: imx: add "jedec,spi-nor" flash compatible binding
Message-ID: <1439707157-15091-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Starting with commit 8947e396a829 ("Documentation: dt: mtd: replace
"nor-jedec" binding with "jedec, spi-nor"") we have "jedec,spi-nor"
binding indicating support for JEDEC identification.

Use it for all flashes that are supposed to support READ ID op according
to the datasheets.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/imx28-evk.dts              | 2 +-
 arch/arm/boot/dts/imx28-m28evk.dts           | 2 +-
 arch/arm/boot/dts/imx50-evk.dts              | 2 +-
 arch/arm/boot/dts/imx53-smd.dts              | 2 +-
 arch/arm/boot/dts/imx6dl-rex-basic.dts       | 2 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts      | 2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts         | 2 +-
 arch/arm/boot/dts/imx6q-rex-pro.dts          | 2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi  | 2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi    | 2 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi     | 2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi     | 2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi       | 2 +-
 arch/arm/boot/dts/imx6sl-evk.dts             | 2 +-
 arch/arm/boot/dts/imx6sx-sdb-reva.dts        | 4 ++--
 arch/arm/boot/dts/imx6sx-sdb.dts             | 4 ++--
 19 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 279249b..e3ef94a 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -57,7 +57,7 @@
 				flash: m25p80 at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "sst,sst25vf016b";
+					compatible = "sst,sst25vf016b", "jedec,spi-nor";
 					spi-max-frequency = <40000000>;
 					reg = <0>;
 				};
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index e35cc6b..8d04e57 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -41,7 +41,7 @@
 				flash: m25p80 at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "m25p80";
+					compatible = "m25p80", "jedec,spi-nor";
 					spi-max-frequency = <40000000>;
 					reg = <0>;
 				};
diff --git a/arch/arm/boot/dts/imx50-evk.dts b/arch/arm/boot/dts/imx50-evk.dts
index 1b22512..27d763c 100644
--- a/arch/arm/boot/dts/imx50-evk.dts
+++ b/arch/arm/boot/dts/imx50-evk.dts
@@ -33,7 +33,7 @@
 	flash: m25p32 at 1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "m25p32", "m25p80";
+		compatible = "m25p32", "jedec,spi-nor";
 		spi-max-frequency = <25000000>;
 		reg = <1>;
 
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 1d32557..fd3a8fe 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -76,7 +76,7 @@
 	flash: m25p32 at 1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "st,m25p32", "st,m25p";
+		compatible = "st,m25p32", "st,m25p", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <1>;
 
diff --git a/arch/arm/boot/dts/imx6dl-rex-basic.dts b/arch/arm/boot/dts/imx6dl-rex-basic.dts
index b13845c..c3a14a4 100644
--- a/arch/arm/boot/dts/imx6dl-rex-basic.dts
+++ b/arch/arm/boot/dts/imx6dl-rex-basic.dts
@@ -23,7 +23,7 @@
 
 &ecspi3 {
 	flash: m25p80 at 0 {
-		compatible = "sst,sst25vf016b";
+		compatible = "sst,sst25vf016b", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index 4fa2543..364578d 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -109,7 +109,7 @@
 	status = "okay";
 
 	flash: m25p80 at 0 {
-		compatible = "m25p80";
+		compatible = "m25p80", "jedec,spi-nor";
 		spi-max-frequency = <40000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 822ffb2..58adf17 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -145,7 +145,7 @@
 	status = "okay";
 
 	flash: m25p80 at 0 {
-		compatible = "sst,w25q256";
+		compatible = "sst,w25q256", "jedec,spi-nor";
 		spi-max-frequency = <30000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6q-rex-pro.dts b/arch/arm/boot/dts/imx6q-rex-pro.dts
index 3c2852b..90ea61a 100644
--- a/arch/arm/boot/dts/imx6q-rex-pro.dts
+++ b/arch/arm/boot/dts/imx6q-rex-pro.dts
@@ -23,7 +23,7 @@
 
 &ecspi3 {
 	flash: m25p80 at 0 {
-		compatible = "sst,sst25vf032b";
+		compatible = "sst,sst25vf032b", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
index e6d9195..0bba6dc 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
@@ -109,7 +109,7 @@
 	flash: m25p80 at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "micron,n25q128a11";
+		compatible = "micron,n25q128a11", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
index 1d85de2..54dd0bc 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
@@ -141,7 +141,7 @@
 	flash: m25p80 at 1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "micron,n25q128a11";
+		compatible = "micron,n25q128a11", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <1>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
index 2c253d6..880b47b 100644
--- a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
@@ -36,7 +36,7 @@
 	flash: m25p80 at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "sst,sst25vf040b", "m25p80";
+		compatible = "sst,sst25vf040b", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 3af16df..a3b8456 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -157,7 +157,7 @@
 	status = "okay";
 
 	flash: m25p80 at 0 {
-		compatible = "sst,sst25vf016b";
+		compatible = "sst,sst25vf016b", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 1ce6133..d6e1402 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -80,7 +80,7 @@
 	cs-gpios = <&gpio4 24 0>;
 
 	flash at 0 {
-		compatible = "m25p80";
+		compatible = "m25p80", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 3b24b126..bfa740a 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -55,7 +55,7 @@
 	flash: m25p80 at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "st,m25p32";
+		compatible = "st,m25p32", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index e00c44f..d192443 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -156,7 +156,7 @@
 	status = "okay";
 
 	flash: m25p80 at 0 {
-		compatible = "sst,sst25vf016b";
+		compatible = "sst,sst25vf016b", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index a626e6d..372a340 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -151,7 +151,7 @@
 	flash: m25p80 at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "st,m25p32";
+		compatible = "st,m25p32", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 945887d..bc70c93 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -126,7 +126,7 @@
 	flash: m25p80 at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "st,m25p32";
+		compatible = "st,m25p32", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
index c76b87c..7100547 100644
--- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
@@ -129,7 +129,7 @@
 		reg = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spansion,s25fl128s";
+		compatible = "spansion,s25fl128s", "jedec,spi-nor";
 		spi-max-frequency = <66000000>;
 	};
 
@@ -137,7 +137,7 @@
 		reg = <1>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spansion,s25fl128s";
+		compatible = "spansion,s25fl128s", "jedec,spi-nor";
 		spi-max-frequency = <66000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index 0bfc4e7..0ad164a 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -130,7 +130,7 @@
 	flash0: n25q256a at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "micron,n25q256a";
+		compatible = "micron,n25q256a", "jedec,spi-nor";
 		spi-max-frequency = <29000000>;
 		reg = <0>;
 	};
@@ -138,7 +138,7 @@
 	flash1: n25q256a at 1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "micron,n25q256a";
+		compatible = "micron,n25q256a", "jedec,spi-nor";
 		spi-max-frequency = <29000000>;
 		reg = <1>;
 	};
-- 
1.8.4.5
