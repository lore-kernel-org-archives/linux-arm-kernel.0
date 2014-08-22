From: dmurphy@ti.com (Dan Murphy)
Date: Fri, 22 Aug 2014 12:12:19 -0500
Subject: [PATCH v2] doc: dt/bindings: input: Fix drv260x binding document
Message-ID: <1408727539-15996-1-git-send-email-dmurphy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the drv260x dt binding document:
- Change the node name to the devices function not the
device name.
- Add vbat-supply to the example.
- Fix indentation of the example.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Address comments on indentation, node declaration, add vbat-supply,
removed description as it did not make sense - https://patchwork.kernel.org/patch/4765141/

 .../devicetree/bindings/input/ti,drv260x.txt       |   23 ++++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/ti,drv260x.txt b/Documentation/devicetree/bindings/input/ti,drv260x.txt
index a9c8519..ee09c8f 100644
--- a/Documentation/devicetree/bindings/input/ti,drv260x.txt
+++ b/Documentation/devicetree/bindings/input/ti,drv260x.txt
@@ -1,6 +1,4 @@
-Texas Instruments - drv260x Haptics driver family
-
-The drv260x family serial control bus communicates through I2C protocols
+* Texas Instruments - drv260x Haptics driver family
 
 Required properties:
 	- compatible - One of:
@@ -37,15 +35,16 @@ Optional properties:
 			  3.2 v.
 Example:
 
-drv2605l: drv2605l at 5a {
-		compatible = "ti,drv2605l";
-		reg = <0x5a>;
-		enable-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
-		mode = <DRV260X_LRA_MODE>;
-		library-sel = <DRV260X_LIB_LRA>;
-		vib-rated-mv = <3200>;
-		vib-overdriver-mv = <3200>;
-};
+haptics: haptics at 5a {
+	compatible = "ti,drv2605l";
+	reg = <0x5a>;
+	vbat-supply = <&vbat>;
+	enable-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	mode = <DRV260X_LRA_MODE>;
+	library-sel = <DRV260X_LIB_LRA>;
+	vib-rated-mv = <3200>;
+	vib-overdriver-mv = <3200>;
+}
 
 For more product information please see the link below:
 http://www.ti.com/product/drv2605
-- 
1.7.9.5
