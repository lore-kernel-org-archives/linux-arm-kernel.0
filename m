From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Thu, 29 Jun 2017 13:51:35 +0530
Subject: [PATCH] media: exynos4-is: fimc-is-i2c: constify dev_pm_ops
 structures.
Message-ID: <82b48f71d328c24e7b526e6bbdff15d03229217a.1498724254.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dev_pm_ops are not supposed to change at runtime. All functions
working with dev_pm_ops provided by <linux/device.h> work with const
dev_pm_ops. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   1195	    376	      0	   1571	    623	drivers/media/platform/exynos4-is/fimc-is-i2c.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   1403	    176	      0	   1579	    62b	drivers/media/platform/exynos4-is/fimc-is-i2c.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/media/platform/exynos4-is/fimc-is-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-is-i2c.c b/drivers/media/platform/exynos4-is/fimc-is-i2c.c
index 2f55966..70dd485 100644
--- a/drivers/media/platform/exynos4-is/fimc-is-i2c.c
+++ b/drivers/media/platform/exynos4-is/fimc-is-i2c.c
@@ -130,7 +130,7 @@ static int fimc_is_i2c_resume(struct device *dev)
 }
 #endif
 
-static struct dev_pm_ops fimc_is_i2c_pm_ops = {
+static const struct dev_pm_ops fimc_is_i2c_pm_ops = {
 	SET_RUNTIME_PM_OPS(fimc_is_i2c_runtime_suspend,
 					fimc_is_i2c_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(fimc_is_i2c_suspend, fimc_is_i2c_resume)
-- 
1.9.1
