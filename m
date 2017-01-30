From: fabf@skynet.be (Fabian Frederick)
Date: Mon, 30 Jan 2017 19:39:47 +0100
Subject: [PATCH 02/14] drm/exynos: use atomic_dec_not_zero()
Message-ID: <20170130183947.12810-1-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

instead of atomic_add_unless(value, -1, 0)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 745cfbd..0e191b6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -923,7 +923,7 @@ static void fimd_te_handler(struct exynos_drm_crtc *crtc)
 	 * If there is a page flip request, triggers and handles the page flip
 	 * event so that current fb can be updated into panel GRAM.
 	 */
-	if (atomic_add_unless(&ctx->win_updated, -1, 0))
+	if (atomic_dec_not_zero(&ctx->win_updated))
 		fimd_trigger(ctx->dev);
 
 out:
-- 
2.9.3
