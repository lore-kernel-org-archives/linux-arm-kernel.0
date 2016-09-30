From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 30 Sep 2016 15:52:44 +0200
Subject: [PATCH v2] drm: tilcdc: add a da850-specific compatible string
Message-ID: <1475243564-15765-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to some potential tweaks for the da850 LCDC (for example: the
required memory bandwith settings) we need a separate compatible
for the IP present on the da850 boards.

Suggested-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
v1 -> v2:
- added the new compatible to the bindings documentation

 Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt | 4 ++--
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                         | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt b/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
index a83abd7..33b6e8a 100644
--- a/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
+++ b/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
@@ -1,7 +1,7 @@
 Device-Tree bindings for tilcdc DRM driver
 
 Required properties:
- - compatible: value should be "ti,am33xx-tilcdc".
+ - compatible: value should be "ti,am33xx-tilcdc" or "ti,da850-tilcdc".
  - interrupts: the interrupt number
  - reg: base address and size of the LCDC device
 
@@ -51,7 +51,7 @@ Optional nodes:
 Example:
 
 	fb: fb at 4830e000 {
-		compatible = "ti,am33xx-tilcdc";
+		compatible = "ti,am33xx-tilcdc", "ti,da850-tilcdc";
 		reg = <0x4830e000 0x1000>;
 		interrupt-parent = <&intc>;
 		interrupts = <36>;
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index a694977..231f2c7 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -723,6 +723,7 @@ static int tilcdc_pdev_remove(struct platform_device *pdev)
 
 static struct of_device_id tilcdc_of_match[] = {
 		{ .compatible = "ti,am33xx-tilcdc", },
+		{ .compatible = "ti,da850-tilcdc", },
 		{ },
 };
 MODULE_DEVICE_TABLE(of, tilcdc_of_match);
-- 
2.9.3
