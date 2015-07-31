From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 31 Jul 2015 15:39:08 +0200
Subject: [PATCH] drm: atmel-hlcdc: add RGB565 and RGB444 output support
Message-ID: <1438349948-6716-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HLCDC IP supports RGB565 and RGB444 output formats.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 9c45130..067e4c1 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -126,12 +126,16 @@ atmel_hlcdc_rgb_encoder_mode_set(struct drm_encoder *encoder,
 
 	if (info->num_bus_formats) {
 		switch (info->bus_formats[0]) {
+		case MEDIA_BUS_FMT_RGB565_1X16:
+			cfg |= ATMEL_HLCDC_CONNECTOR_RGB565 << 8;
+			break;
 		case MEDIA_BUS_FMT_RGB666_1X18:
 			cfg |= ATMEL_HLCDC_CONNECTOR_RGB666 << 8;
 			break;
 		case MEDIA_BUS_FMT_RGB888_1X24:
 			cfg |= ATMEL_HLCDC_CONNECTOR_RGB888 << 8;
 			break;
+		case MEDIA_BUS_FMT_RGB444_1X12:
 		default:
 			break;
 		}
-- 
1.9.1
