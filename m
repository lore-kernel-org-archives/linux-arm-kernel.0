From: geliangtang@gmail.com (Geliang Tang)
Date: Fri, 18 Nov 2016 22:03:29 +0800
Subject: [PATCH] drm: mediatek: use ERR_CAST inlined function
Message-ID: <6ead9aa2438aa8ce5ba8b9a1f1c661b9d4e53c26.1479460645.git.geliangtang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...)).

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 7abc550..8d25ff0 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -245,7 +245,7 @@ struct drm_gem_object *mtk_gem_prime_import_sg_table(struct drm_device *dev,
 	mtk_gem = mtk_drm_gem_init(dev, attach->dmabuf->size);
 
 	if (IS_ERR(mtk_gem))
-		return ERR_PTR(PTR_ERR(mtk_gem));
+		return ERR_CAST(mtk_gem);
 
 	expected = sg_dma_address(sg->sgl);
 	for_each_sg(sg->sgl, s, sg->nents, i) {
-- 
2.9.3
