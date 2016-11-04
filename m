From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Fri,  4 Nov 2016 07:13:52 +0100
Subject: [PATCH] drm/sun4i: Propagate error to the caller
Message-ID: <20161104061352.12596-1-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If 'sun4i_layers_init()' returns an error, propagate it instead of
returning -EINVAL unconditionally.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 628712e6edd6..ee4e5f987b6f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -145,7 +145,7 @@ static int sun4i_drv_bind(struct device *dev)
 	drv->layers = sun4i_layers_init(drm);
 	if (IS_ERR(drv->layers)) {
 		dev_err(drm->dev, "Couldn't create the planes\n");
-		ret = -EINVAL;
+		ret = PTR_ERR(drv->layers);
 		goto free_drm;
 	}
 
-- 
2.9.3
