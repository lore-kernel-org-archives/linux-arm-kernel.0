From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Sun, 30 Oct 2016 09:49:26 +0100
Subject: [PATCH] drm/sun4i: Fix error handling
Message-ID: <20161030084926.15303-1-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'sun4i_layers_init()' returns an error pointer in case of error, not
NULL. So test it with IS_ERR.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 9776f0305834..628712e6edd6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -143,7 +143,7 @@ static int sun4i_drv_bind(struct device *dev)
 
 	/* Create our layers */
 	drv->layers = sun4i_layers_init(drm);
-	if (!drv->layers) {
+	if (IS_ERR(drv->layers)) {
 		dev_err(drm->dev, "Couldn't create the planes\n");
 		ret = -EINVAL;
 		goto free_drm;
-- 
2.9.3
