From: festevam@gmail.com (Fabio Estevam)
Date: Thu,  4 Sep 2014 22:31:20 -0300
Subject: [PATCH v2 3/6] ARM: dts: imx28-cfa100: Fix display duplicate name
 warning
In-Reply-To: <1409880683-27402-1-git-send-email-festevam@gmail.com>
References: <1409880683-27402-1-git-send-email-festevam@gmail.com>
Message-ID: <1409880683-27402-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The lcdif node has a property named "display" and also a child node
called "display", which causes the following warning:

device-tree: Duplicate name in lcdif at 80030000, renamed to "display#1"

Rename the child node name in order to avoid the warning.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/imx28-cfa10049.dts | 4 ++--
 arch/arm/boot/dts/imx28-cfa10055.dts | 4 ++--
 arch/arm/boot/dts/imx28-cfa10056.dts | 4 ++--
 arch/arm/boot/dts/imx28-cfa10057.dts | 4 ++--
 arch/arm/boot/dts/imx28-cfa10058.dts | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index 7d51459..ef944b6 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -177,10 +177,10 @@
 				pinctrl-0 = <&lcdif_18bit_pins_cfa10049
 					     &lcdif_pins_cfa10049
 					     &lcdif_pins_cfa10049_pullup>;
-				display = <&display>;
+				display = <&display0>;
 				status = "okay";
 
-				display: display {
+				display0: display0 {
 					bits-per-pixel = <32>;
 					bus-width = <18>;
 
diff --git a/arch/arm/boot/dts/imx28-cfa10055.dts b/arch/arm/boot/dts/imx28-cfa10055.dts
index c3900e7..6a34114 100644
--- a/arch/arm/boot/dts/imx28-cfa10055.dts
+++ b/arch/arm/boot/dts/imx28-cfa10055.dts
@@ -92,10 +92,10 @@
 				pinctrl-0 = <&lcdif_18bit_pins_cfa10055
 					     &lcdif_pins_cfa10055
 					     &lcdif_pins_cfa10055_pullup>;
-				display = <&display>;
+				display = <&display0>;
 				status = "okay";
 
-				display: display {
+				display0: display0 {
 					bits-per-pixel = <32>;
 					bus-width = <18>;
 
diff --git a/arch/arm/boot/dts/imx28-cfa10056.dts b/arch/arm/boot/dts/imx28-cfa10056.dts
index cef959a..ba6495c 100644
--- a/arch/arm/boot/dts/imx28-cfa10056.dts
+++ b/arch/arm/boot/dts/imx28-cfa10056.dts
@@ -64,10 +64,10 @@
 				pinctrl-0 = <&lcdif_24bit_pins_a
 						&lcdif_pins_cfa10056
 						&lcdif_pins_cfa10056_pullup >;
-				display = <&display>;
+				display = <&display0>;
 				status = "okay";
 
-				display: display {
+				display0: display0 {
 					bits-per-pixel = <32>;
 					bus-width = <24>;
 
diff --git a/arch/arm/boot/dts/imx28-cfa10057.dts b/arch/arm/boot/dts/imx28-cfa10057.dts
index c4e00ce..5df0b24 100644
--- a/arch/arm/boot/dts/imx28-cfa10057.dts
+++ b/arch/arm/boot/dts/imx28-cfa10057.dts
@@ -78,10 +78,10 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_18bit_pins_cfa10057
 					     &lcdif_pins_cfa10057>;
-				display = <&display>;
+				display = <&display0>;
 				status = "okay";
 
-				display: display {
+				display0: display0 {
 					bits-per-pixel = <32>;
 					bus-width = <18>;
 
diff --git a/arch/arm/boot/dts/imx28-cfa10058.dts b/arch/arm/boot/dts/imx28-cfa10058.dts
index 7c9cc78..f5c6dce 100644
--- a/arch/arm/boot/dts/imx28-cfa10058.dts
+++ b/arch/arm/boot/dts/imx28-cfa10058.dts
@@ -51,10 +51,10 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_24bit_pins_a
 						 &lcdif_pins_cfa10058>;
-				display = <&display>;
+				display = <&display0>;
 				status = "okay";
 
-				display: display {
+				display0: display0 {
 					bits-per-pixel = <32>;
 					bus-width = <24>;
 
-- 
1.9.1
