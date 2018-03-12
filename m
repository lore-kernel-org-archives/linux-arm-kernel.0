From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Mon, 12 Mar 2018 21:15:09 +0100
Subject: [PATCH 2/3] drm/meson: Use drm_dev_put() instead of drm_dev_unref()
In-Reply-To: <cover.1520885192.git.christophe.jaillet@wanadoo.fr>
References: <cover.1520885192.git.christophe.jaillet@wanadoo.fr>
Message-ID: <d4ce46077d3ada7149c4555acfdda8ade4a6cf50.1520885192.git.christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to 'drivers/gpu/drm/drm_drv.c', 'drm_dev_unref()' is just a
compatibility alias for 'drm_dev_put()'. So use the latter instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/meson/meson_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 02b0886debc0..6ee3dd7fa450 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -284,7 +284,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	return 0;
 
 free_drm:
-	drm_dev_unref(drm);
+	drm_dev_put(drm);
 
 	return ret;
 }
@@ -303,7 +303,7 @@ static void meson_drv_unbind(struct device *dev)
 	drm_kms_helper_poll_fini(drm);
 	drm_fbdev_cma_fini(priv->fbdev);
 	drm_mode_config_cleanup(drm);
-	drm_dev_unref(drm);
+	drm_dev_put(drm);
 
 }
 
-- 
2.14.1


---
L'absence de virus dans ce courrier ?lectronique a ?t? v?rifi?e par le logiciel antivirus Avast.
https://www.avast.com/antivirus
