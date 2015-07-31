From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 31 Jul 2015 15:37:31 +0200
Subject: [PATCH] drm: atmel-hlcdc: add PRIME support
Message-ID: <1438349851-6502-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 60b0c13..2af75e4 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -485,7 +485,8 @@ static const struct file_operations fops = {
 };
 
 static struct drm_driver atmel_hlcdc_dc_driver = {
-	.driver_features = DRIVER_HAVE_IRQ | DRIVER_GEM | DRIVER_MODESET,
+	.driver_features = DRIVER_HAVE_IRQ | DRIVER_GEM |
+			   DRIVER_MODESET | DRIVER_PRIME,
 	.preclose = atmel_hlcdc_dc_preclose,
 	.lastclose = atmel_hlcdc_dc_lastclose,
 	.irq_handler = atmel_hlcdc_dc_irq_handler,
@@ -497,6 +498,15 @@ static struct drm_driver atmel_hlcdc_dc_driver = {
 	.disable_vblank = atmel_hlcdc_dc_disable_vblank,
 	.gem_free_object = drm_gem_cma_free_object,
 	.gem_vm_ops = &drm_gem_cma_vm_ops,
+	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
+	.gem_prime_import = drm_gem_prime_import,
+	.gem_prime_export = drm_gem_prime_export,
+	.gem_prime_get_sg_table = drm_gem_cma_prime_get_sg_table,
+	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
+	.gem_prime_vmap = drm_gem_cma_prime_vmap,
+	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
+	.gem_prime_mmap = drm_gem_cma_prime_mmap,
 	.dumb_create = drm_gem_cma_dumb_create,
 	.dumb_map_offset = drm_gem_cma_dumb_map_offset,
 	.dumb_destroy = drm_gem_dumb_destroy,
-- 
1.9.1
