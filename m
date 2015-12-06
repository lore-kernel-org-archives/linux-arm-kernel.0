From: zhaoxiu.zeng@gmail.com (Zhaoxiu Zeng)
Date: Sun,  6 Dec 2015 18:44:29 +0800
Subject: [PATCH 05/10] exynos4-is: Replace "hweight32(mask) == 1" with
 "is_power_of_2(mask)"
Message-ID: <1449398669-14507-1-git-send-email-zhaoxiu.zeng@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
---
 drivers/media/platform/exynos4-is/fimc-is-regs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-is-regs.c b/drivers/media/platform/exynos4-is/fimc-is-regs.c
index cfe4406..ec75a24 100644
--- a/drivers/media/platform/exynos4-is/fimc-is-regs.c
+++ b/drivers/media/platform/exynos4-is/fimc-is-regs.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/delay.h>
+#include <linux/log2.h>
 
 #include "fimc-is.h"
 #include "fimc-is-command.h"
@@ -107,7 +108,7 @@ int fimc_is_hw_get_params(struct fimc_is *is, unsigned int num_args)
 
 void fimc_is_hw_set_isp_buf_mask(struct fimc_is *is, unsigned int mask)
 {
-	if (hweight32(mask) == 1) {
+	if (is_power_of_2(mask)) {
 		dev_err(&is->pdev->dev, "%s(): not enough buffers (mask %#x)\n",
 							__func__, mask);
 		return;
-- 
2.5.0
