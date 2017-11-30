From: d-gerlach@ti.com (Dave Gerlach)
Date: Thu, 30 Nov 2017 16:56:07 -0600
Subject: [PATCH v6 1/2] Documentation: dt: Update ti,emif bindings
In-Reply-To: <1512082568-5012-1-git-send-email-d-gerlach@ti.com>
References: <1512082568-5012-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1512082568-5012-2-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the Texas Instruments EMIF binding document to include the device
tree bindings for ti,emif-am3352 and ti,emif-am4372 which are used by
the ti-emif-sram driver to provide low-level PM functionality.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 .../devicetree/bindings/memory-controllers/ti/emif.txt  | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
index fd823d6091b2..29a99871e808 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
@@ -23,6 +23,13 @@ Required properties:
   the value shall be "emif<n>" where <n> is the number of the EMIF
   instance with base 1.
 
+Required only for "ti,emif-am3352" and "ti,emif-am4372":
+- sram			: Phandles for generic sram driver nodes,
+  first should be type 'protect-exec' for the driver to use to copy
+  and run PM functions, second should be regular pool to be used for
+  data region for code. See Documentation/devicetree/bindings/sram/sram.txt
+  for more details.
+
 Optional properties:
 - cs1-used		: Have this property if CS1 of this EMIF
   instance has a memory part attached to it. If there is a memory
@@ -44,7 +51,7 @@ Optional properties:
 - hw-caps-temp-alert	: Have this property if the controller
   has capability for generating SDRAM temperature alerts
 
-Example:
+-Examples:
 
 emif1: emif at 0x4c000000 {
 	compatible	= "ti,emif-4d";
@@ -56,3 +63,11 @@ emif1: emif at 0x4c000000 {
 	hw-caps-ll-interface;
 	hw-caps-temp-alert;
 };
+
+/* From am33xx.dtsi */
+emif: emif at 4c000000 {
+        compatible = "ti,emif-am3352";
+        reg =   <0x4C000000 0x1000>;
+        sram = <&pm_sram_code
+                &pm_sram_data>;
+};
-- 
2.15.0
