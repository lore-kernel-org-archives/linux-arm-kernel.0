From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  6 Oct 2014 21:50:38 +0200
Subject: [PATCH 1/3] staging: drm/imx: parallel-display: Add 24-bit BGR support
Message-ID: <1412625040-15662-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

Add support for the BGR24 format to the IPUv3 parallel display.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt | 4 ++--
 drivers/staging/imx-drm/parallel-display.c                        | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
index e75f0e549fff..f3497037679e 100644
--- a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
+++ b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
@@ -60,8 +60,8 @@ Required properties:
 - compatible: Should be "fsl,imx-parallel-display"
 Optional properties:
 - interface_pix_fmt: How this display is connected to the
-  display interface. Currently supported types: "rgb24", "rgb565", "bgr666"
-  and "lvds666".
+  display interface. Currently supported types: "rgb24", "bgr24", "rgb565",
+  "bgr666", and "lvds666".
 - edid: verbatim EDID data block describing attached display.
 - ddc: phandle describing the i2c bus handling the display data
   channel
diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index 4ca61afdf622..df0c3e759616 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -227,6 +227,8 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 			imxpd->interface_pix_fmt = V4L2_PIX_FMT_BGR666;
 		else if (!strcmp(fmt, "lvds666"))
 			imxpd->interface_pix_fmt = v4l2_fourcc('L', 'V', 'D', '6');
+		else if (!strcmp(fmt, "bgr24"))
+			imxpd->interface_pix_fmt = V4L2_PIX_FMT_BGR24;
 	}
 
 	panel_node = of_parse_phandle(np, "fsl,panel", 0);
-- 
2.1.0
