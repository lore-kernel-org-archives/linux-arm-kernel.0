From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 19 Dec 2015 16:23:11 +0100
Subject: [PATCH] [media] gsc-m2m: Use an unsigned data type for a variable
Message-ID: <5675765F.9020002@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 19 Dec 2015 15:28:37 +0100

The data type "int" was used by the variable "ret" in the
gsc_m2m_poll() function despite of the aspect that the type "unsigned int"
will usually be needed for the return value from a call of the
v4l2_m2m_poll() function.
Improve this implementation detail by addition of the type modifier then.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/media/platform/exynos-gsc/gsc-m2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-m2m.c b/drivers/media/platform/exynos-gsc/gsc-m2m.c
index d82e717..f2c091c 100644
--- a/drivers/media/platform/exynos-gsc/gsc-m2m.c
+++ b/drivers/media/platform/exynos-gsc/gsc-m2m.c
@@ -701,7 +701,7 @@ static unsigned int gsc_m2m_poll(struct file *file,
 {
 	struct gsc_ctx *ctx = fh_to_ctx(file->private_data);
 	struct gsc_dev *gsc = ctx->gsc_dev;
-	int ret;
+	unsigned int ret;
 
 	if (mutex_lock_interruptible(&gsc->lock))
 		return -ERESTARTSYS;
-- 
2.6.3
