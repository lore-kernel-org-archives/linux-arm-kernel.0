From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue, 19 May 2015 13:30:46 +0200
Subject: [PATCH] ARM: mvebu: add "jedec,spi-nor" flash compatible binding
Message-ID: <1432035046-12888-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Starting with commit 8947e396a829 ("Documentation: dt: mtd: replace
"nor-jedec" binding with "jedec, spi-nor"") we have "jedec,spi-nor"
binding indicating support for JEDEC identification.

Use it for all flashes that are supposed to support READ ID op according
to the datasheets.

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
 arch/arm/boot/dts/armada-xp-synology-ds414.dts   | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 19f3bf2..03542f7 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -162,7 +162,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "mx25l25635e";
+					compatible = "mx25l25635e", "jedec,spi-nor";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <50000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index b42b767..4f49243 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -92,7 +92,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "micron,n25q064";
+					compatible = "micron,n25q064", "jedec,spi-nor";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <20000000>;
 
diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index 4eabc9c..5711b97 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -81,7 +81,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "n25q128a13";
+					compatible = "n25q128a13", "jedec,spi-nor";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <108000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
index 7219ac3..89f5a95 100644
--- a/arch/arm/boot/dts/armada-385-db-ap.dts
+++ b/arch/arm/boot/dts/armada-385-db-ap.dts
@@ -70,7 +70,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "st,m25p128";
+					compatible = "st,m25p128", "jedec,spi-nor";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <54000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
index 51d1623..91ac8c1 100644
--- a/arch/arm/boot/dts/armada-388-db.dts
+++ b/arch/arm/boot/dts/armada-388-db.dts
@@ -73,7 +73,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "w25q32";
+					compatible = "w25q32", "jedec,spi-nor";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <108000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 78514ab..fd4f6fd 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -69,7 +69,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "st,m25p128";
+					compatible = "st,m25p128", "jedec,spi-nor";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <50000000>;
 					m25p,fast-read;
diff --git a/arch/arm/boot/dts/armada-388-rd.dts b/arch/arm/boot/dts/armada-388-rd.dts
index 1dc6e23..b657b16 100644
--- a/arch/arm/boot/dts/armada-388-rd.dts
+++ b/arch/arm/boot/dts/armada-388-rd.dts
@@ -74,7 +74,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "st,m25p128";
+					compatible = "st,m25p128", "jedec,spi-nor";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <108000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-398-db.dts b/arch/arm/boot/dts/armada-398-db.dts
index bbf8375..788c3ba 100644
--- a/arch/arm/boot/dts/armada-398-db.dts
+++ b/arch/arm/boot/dts/armada-398-db.dts
@@ -73,7 +73,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "n25q128a13";
+					compatible = "n25q128a13", "jedec,spi-nor";
 					reg = <0>;
 					spi-max-frequency = <108000000>;
 
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index dfd782b..60bbfe3 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -140,7 +140,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "n25q128a13";
+					compatible = "n25q128a13", "jedec,spi-nor";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <108000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 1037824..7dd900f 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -222,7 +222,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "m25p64";
+					compatible = "m25p64", "jedec,spi-nor";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <20000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 565227e..bf724ca 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -227,7 +227,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "n25q128a13";
+					compatible = "n25q128a13", "jedec,spi-nor";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <108000000>;
 				};
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index 6063428..20267ad 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -114,7 +114,7 @@
 				spi-flash at 0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
-					compatible = "micron,n25q064";
+					compatible = "micron,n25q064", "jedec,spi-nor";
 					reg = <0>; /* Chip select 0 */
 					spi-max-frequency = <20000000>;
 
-- 
1.8.4.5
