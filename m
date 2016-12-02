From: shailendra.v@samsung.com (Shailendra Verma)
Date: Fri, 02 Dec 2016 10:13:05 +0530
Subject: [PATCH] exynos4-is: Clean up file handle in open() error path.
Message-ID: <1480653785-6713-1-git-send-email-shailendra.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The File handle is not yet added in the vfd list.So no need to call 
v4l2_fh_del(&ctx->fh) if it fails to create control.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 drivers/media/platform/exynos4-is/fimc-m2m.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-m2m.c b/drivers/media/platform/exynos4-is/fimc-m2m.c
index 6028e4f..d8724fe 100644
--- a/drivers/media/platform/exynos4-is/fimc-m2m.c
+++ b/drivers/media/platform/exynos4-is/fimc-m2m.c
@@ -663,8 +663,8 @@ static int fimc_m2m_open(struct file *file)
 	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 error_c:
 	fimc_ctrls_delete(ctx);
-error_fh:
 	v4l2_fh_del(&ctx->fh);
+error_fh:
 	v4l2_fh_exit(&ctx->fh);
 	kfree(ctx);
 unlock:
-- 
1.7.9.5
