From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 18 Sep 2016 09:59:50 +0200
Subject: [PATCH] dmaengine: sun6i: Add support for Allwinner A83T (sun8i)
 variant
Message-ID: <mailman.50.1474185689.1636.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T SoC has the same dma engine as the A31 (sun6i), with a reduced
amount of endpoints and physical channels.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/dma/sun6i-dma.txt | 1 +
 drivers/dma/sun6i-dma.c                             | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
index d13c136..6b26704 100644
--- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible:	Must be one of
 		  "allwinner,sun6i-a31-dma"
 		  "allwinner,sun8i-a23-dma"
+		  "allwinner,sun8i-a83t-dma"
 		  "allwinner,sun8i-h3-dma"
 - reg:		Should contain the registers base address and length
 - interrupts:	Should contain a reference to the interrupt used by this device
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 3835fcd..8346199 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1011,6 +1011,12 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.nr_max_vchans   = 37,
 };
 
+static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
+	.nr_max_channels = 8,
+	.nr_max_requests = 28,
+	.nr_max_vchans   = 39,
+};
+
 /*
  * The H3 has 12 physical channels, a maximum DRQ port id of 27,
  * and a total of 34 usable source and destination endpoints.
@@ -1025,6 +1031,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 static const struct of_device_id sun6i_dma_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-dma", .data = &sun6i_a31_dma_cfg },
 	{ .compatible = "allwinner,sun8i-a23-dma", .data = &sun8i_a23_dma_cfg },
+	{ .compatible = "allwinner,sun8i-a83t-dma", .data = &sun8i_a83t_dma_cfg },
 	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
 	{ /* sentinel */ }
 };
-- 
2.10.0
