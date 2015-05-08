From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Fri,  8 May 2015 08:20:23 +0200
Subject: [PATCH] ARM: mvebu: add "nor-jedec" flash compatible binding
Message-ID: <1431066023-19479-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Starting with commits
8ff16cf ("Documentation: devicetree: m25p80: add "nor-jedec" binding")
1103b85 ("mtd: m25p80: bind to "nor-jedec" ID, for auto-detection")
we have "nor-jedec" binding indicating support for JEDEC identification.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/armada-370-db.dts              | 2 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts | 2 +-
 arch/arm/boot/dts/armada-375-db.dts              | 2 +-
 arch/arm/boot/dts/armada-385-db-ap.dts           | 2 +-
 arch/arm/boot/dts/armada-388-db.dts              | 2 +-
 arch/arm/boot/dts/armada-388-gp.dts              | 2 +-
 arch/arm/boot/dts/armada-388-rd.dts              | 2 +-
 arch/arm/boot/dts/armada-398-db.dts              | 2 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 2 +-
 arch/arm/boot/dts/armada-xp-db.dts               | 2 +-
 arch/arm/boot/dts/armada-xp-gp.dts               | 2 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts    | 2 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts   | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 19f3bf2..972bfc9 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -162,7 +162,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "mx25l25635e";
+					compatible = "mx25l25635e", "nor-jedec";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <50000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index b42b767..2d6c2d4 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -92,7 +92,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "micron,n25q064";
+					compatible = "micron,n25q064", "nor-jedec";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <20000000>;
 
diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index 4eabc9c..db52cdb 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -81,7 +81,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "n25q128a13";
+					compatible = "n25q128a13", "nor-jedec";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <108000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
index 7219ac3..0f9d063 100644
--- a/arch/arm/boot/dts/armada-385-db-ap.dts
+++ b/arch/arm/boot/dts/armada-385-db-ap.dts
@@ -70,7 +70,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "st,m25p128";
+					compatible = "st,m25p128", "nor-jedec";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <54000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
index 51d1623..3b5b8b5 100644
--- a/arch/arm/boot/dts/armada-388-db.dts
+++ b/arch/arm/boot/dts/armada-388-db.dts
@@ -73,7 +73,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "w25q32";
+					compatible = "w25q32", "nor-jedec";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <108000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 78514ab..df700e6 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -69,7 +69,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "st,m25p128";
+					compatible = "st,m25p128", "nor-jedec";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <50000000>;
 					m25p,fast-read;
diff --git a/arch/arm/boot/dts/armada-388-rd.dts b/arch/arm/boot/dts/armada-388-rd.dts
index 1dc6e23..388fd1d 100644
--- a/arch/arm/boot/dts/armada-388-rd.dts
+++ b/arch/arm/boot/dts/armada-388-rd.dts
@@ -74,7 +74,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "st,m25p128";
+					compatible = "st,m25p128", "nor-jedec";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <108000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-398-db.dts b/arch/arm/boot/dts/armada-398-db.dts
index bbf8375..ec5ce94 100644
--- a/arch/arm/boot/dts/armada-398-db.dts
+++ b/arch/arm/boot/dts/armada-398-db.dts
@@ -73,7 +73,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "n25q128a13";
+					compatible = "n25q128a13", "nor-jedec";
 					reg = <0>;
 					spi-max-frequency = <108000000>;
 
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index dfd782b..1cbd1e5 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -140,7 +140,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "n25q128a13";
+					compatible = "n25q128a13", "nor-jedec";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <108000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 1037824..a9fd0ef 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -222,7 +222,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "m25p64";
+					compatible = "m25p64", "nor-jedec";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <20000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 565227e..1deec67 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -227,7 +227,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "n25q128a13";
+					compatible = "n25q128a13", "nor-jedec";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <108000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index a2cf215..e9a746b 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -279,7 +279,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "everspin,mr25h256";
+					compatible = "everspin,mr25h256", "nor-jedec";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <40000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index 6063428..46830e2 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -114,7 +114,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "micron,n25q064";
+					compatible = "micron,n25q064", "nor-jedec";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <20000000>;
 
-- 
1.8.4.5
