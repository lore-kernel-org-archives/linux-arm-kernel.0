From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 31 Jul 2015 15:38:34 +0200
Subject: [PATCH] drm: atmel-hlcdc: add the missing DRM_ATOMIC flag
Message-ID: <1438349914-6609-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atmel-hlcdc driver already supports atomic operations, add the
missing DRM_ATOMIC flag to expose the atomic features to userspace.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 2af75e4..51d6c77 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -486,7 +486,8 @@ static const struct file_operations fops = {
 
 static struct drm_driver atmel_hlcdc_dc_driver = {
 	.driver_features = DRIVER_HAVE_IRQ | DRIVER_GEM |
-			   DRIVER_MODESET | DRIVER_PRIME,
+			   DRIVER_MODESET | DRIVER_PRIME |
+			   DRIVER_ATOMIC,
 	.preclose = atmel_hlcdc_dc_preclose,
 	.lastclose = atmel_hlcdc_dc_lastclose,
 	.irq_handler = atmel_hlcdc_dc_irq_handler,
-- 
1.9.1
