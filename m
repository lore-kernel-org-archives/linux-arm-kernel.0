From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 07 May 2015 09:04:46 +0900
Subject: [RFT PATCH v2 3/3] drm/exynos: Consolidate return statements in
 fimd_bind()
In-Reply-To: <1430957086-25005-1-git-send-email-k.kozlowski@samsung.com>
References: <1430957086-25005-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1430957086-25005-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Simplify the code and remove superfluous return statement. Just return
the result of fimd_iommu_attach_devices().

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

---
Changes since v1:
New patch.
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 5c1a148525f8..d704f2ba7179 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -1042,12 +1042,7 @@ static int fimd_bind(struct device *dev, struct device *master, void *data)
 	if (ctx->display)
 		exynos_drm_create_enc_conn(drm_dev, ctx->display);
 
-	ret = fimd_iommu_attach_devices(ctx, drm_dev);
-	if (ret)
-		return ret;
-
-	return 0;
-
+	return fimd_iommu_attach_devices(ctx, drm_dev);
 }
 
 static void fimd_unbind(struct device *dev, struct device *master,
-- 
2.1.4
