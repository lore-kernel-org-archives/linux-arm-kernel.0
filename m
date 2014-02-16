From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 16 Feb 2014 20:10:55 +0100
Subject: [PATCH] dma: sdma: Add imx25 compatible
Message-ID: <1392577855-23375-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx25 did not work without a firmware previously.

This patch adds a DT compatible to pass the correct data with the
default script addresses for imx25.

Add imx25 compatible to the list of compatibles in the binding
documentation.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 16 ++++++++++------
 drivers/dma/imx-sdma.c                                 |  1 +
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index 68b83ec..ee9be99 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -1,12 +1,16 @@
 * Freescale Smart Direct Memory Access (SDMA) Controller for i.MX
 
 Required properties:
-- compatible : Should be "fsl,imx31-sdma", "fsl,imx31-to1-sdma",
-  "fsl,imx31-to2-sdma", "fsl,imx35-sdma", "fsl,imx35-to1-sdma",
-  "fsl,imx35-to2-sdma", "fsl,imx51-sdma", "fsl,imx53-sdma" or
-  "fsl,imx6q-sdma". The -to variants should be preferred since they
-  allow to determnine the correct ROM script addresses needed for
-  the driver to work without additional firmware.
+- compatible : Should be one of
+      "fsl,imx25-sdma"
+      "fsl,imx31-sdma", "fsl,imx31-to1-sdma", "fsl,imx31-to2-sdma"
+      "fsl,imx35-sdma", "fsl,imx35-to1-sdma", "fsl,imx35-to2-sdma"
+      "fsl,imx51-sdma"
+      "fsl,imx53-sdma"
+      "fsl,imx6q-sdma"
+  The -to variants should be preferred since they allow to determnine the
+  correct ROM script addresses needed for the driver to work without additional
+  firmware.
 - reg : Should contain SDMA registers location and length
 - interrupts : Should contain SDMA interrupt
 - #dma-cells : Must be <3>.
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index bdefc10..ce2ad7f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -449,6 +449,7 @@ static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx51-sdma", .data = &sdma_imx51, },
 	{ .compatible = "fsl,imx35-sdma", .data = &sdma_imx35, },
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
+	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdma_dt_ids);
-- 
1.8.5.3
