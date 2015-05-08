From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Fri,  8 May 2015 08:21:19 +0200
Subject: [PATCH] ARM: dts: kirkwood: add "nor-jedec" flash compatible binding
Message-ID: <1431066079-19725-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Starting with commits
8ff16cf ("Documentation: devicetree: m25p80: add "nor-jedec" binding")
1103b85 ("mtd: m25p80: bind to "nor-jedec" ID, for auto-detection")
we have "nor-jedec" binding indicating support for JEDEC identification.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/kirkwood-b3.dts              | 2 +-
 arch/arm/boot/dts/kirkwood-cloudbox.dts        | 2 +-
 arch/arm/boot/dts/kirkwood-dir665.dts          | 2 +-
 arch/arm/boot/dts/kirkwood-dreamplug.dts       | 2 +-
 arch/arm/boot/dts/kirkwood-lsxl.dtsi           | 2 +-
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 2 +-
 arch/arm/boot/dts/kirkwood-netxbig.dtsi        | 2 +-
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi     | 2 +-
 arch/arm/boot/dts/kirkwood-rd88f6192.dts       | 2 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi       | 2 +-
 arch/arm/boot/dts/kirkwood-t5325.dts           | 2 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi          | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-b3.dts b/arch/arm/boot/dts/kirkwood-b3.dts
index c9247f8..103551f 100644
--- a/arch/arm/boot/dts/kirkwood-b3.dts
+++ b/arch/arm/boot/dts/kirkwood-b3.dts
@@ -74,7 +74,7 @@
 			m25p16 at 0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "st,m25p16";
+				compatible = "st,m25p16", "nor-jedec";
 				reg = <0>;
 				spi-max-frequency = <40000000>;
 				mode = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-cloudbox.dts b/arch/arm/boot/dts/kirkwood-cloudbox.dts
index ab6ab49..4a04985 100644
--- a/arch/arm/boot/dts/kirkwood-cloudbox.dts
+++ b/arch/arm/boot/dts/kirkwood-cloudbox.dts
@@ -42,7 +42,7 @@
 			flash at 0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "mxicy,mx25l4005a";
+				compatible = "mxicy,mx25l4005a", "nor-jedec";
 				reg = <0>;
 				spi-max-frequency = <20000000>;
 				mode = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-dir665.dts b/arch/arm/boot/dts/kirkwood-dir665.dts
index 786959e..94c80a2 100644
--- a/arch/arm/boot/dts/kirkwood-dir665.dts
+++ b/arch/arm/boot/dts/kirkwood-dir665.dts
@@ -93,7 +93,7 @@
 			m25p80 at 0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "mxicy,mx25l12805d";
+				compatible = "mxicy,mx25l12805d", "nor-jedec";
 				spi-max-frequency = <50000000>;
 				reg = <0>;
 
diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index 6467c79..c9a1c09 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -42,7 +42,7 @@
 			m25p40 at 0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "mxicy,mx25l1606e";
+				compatible = "mxicy,mx25l1606e", "nor-jedec";
 				reg = <0>;
 				spi-max-frequency = <50000000>;
 				mode = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
index 5348447..58e197a 100644
--- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -74,7 +74,7 @@
 			m25p40 at 0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "m25p40";
+				compatible = "m25p40", "nor-jedec";
 				reg = <0>;
 				spi-max-frequency = <25000000>;
 				mode = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
index f82827d..ae68061 100644
--- a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
+++ b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
@@ -65,7 +65,7 @@
 			flash at 0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "mxicy,mx25l12805d";
+				compatible = "mxicy,mx25l12805d", "nor-jedec";
 				reg = <0>;
 				spi-max-frequency = <50000000>;
 				mode = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-netxbig.dtsi b/arch/arm/boot/dts/kirkwood-netxbig.dtsi
index b0cfb7c..11d21c0 100644
--- a/arch/arm/boot/dts/kirkwood-netxbig.dtsi
+++ b/arch/arm/boot/dts/kirkwood-netxbig.dtsi
@@ -33,7 +33,7 @@
 			flash at 0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "mxicy,mx25l4005a";
+				compatible = "mxicy,mx25l4005a", "nor-jedec";
 				reg = <0>;
 				spi-max-frequency = <20000000>;
 				mode = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
index fe6c024..b860b7f 100644
--- a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
@@ -29,7 +29,7 @@
 			flash at 0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "mxicy,mx25l4005a";
+				compatible = "mxicy,mx25l4005a", "nor-jedec";
 				reg = <0>;
 				spi-max-frequency = <20000000>;
 				mode = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6192.dts b/arch/arm/boot/dts/kirkwood-rd88f6192.dts
index 35a29de..80dff2f 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6192.dts
+++ b/arch/arm/boot/dts/kirkwood-rd88f6192.dts
@@ -61,7 +61,7 @@
 			m25p128 at 0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "st,m25p128";
+				compatible = "st,m25p128", "nor-jedec";
 				reg = <0>;
 				spi-max-frequency = <20000000>;
 				mode = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-synology.dtsi b/arch/arm/boot/dts/kirkwood-synology.dtsi
index 8be5b2e..48f4b02 100644
--- a/arch/arm/boot/dts/kirkwood-synology.dtsi
+++ b/arch/arm/boot/dts/kirkwood-synology.dtsi
@@ -217,7 +217,7 @@
 			m25p80 at 0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "st,m25p80";
+				compatible = "st,m25p80", "nor-jedec";
 				reg = <0>;
 				spi-max-frequency = <20000000>;
 				mode = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/kirkwood-t5325.dts
index 610ec0f..5dbd9a0 100644
--- a/arch/arm/boot/dts/kirkwood-t5325.dts
+++ b/arch/arm/boot/dts/kirkwood-t5325.dts
@@ -88,7 +88,7 @@
 			flash at 0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "st,m25p80";
+				compatible = "st,m25p80", "nor-jedec";
 				spi-max-frequency = <86000000>;
 				reg = <0>;
 				mode = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
index df7f152..cbb1049 100644
--- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@ -49,7 +49,7 @@
 			m25p128 at 0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "m25p128";
+				compatible = "m25p128", "nor-jedec";
 				reg = <0>;
 				spi-max-frequency = <20000000>;
 				mode = <0>;
-- 
1.8.4.5
