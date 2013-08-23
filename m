From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 23 Aug 2013 12:36:56 +0300
Subject: [patch] [media] exynos4-is: print error message on timeout
Message-ID: <20130823093656.GK31293@elgon.mountain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a stray '!' character so the error message never gets printed.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static checker stuff.  Not tested.

diff --git a/drivers/media/platform/exynos4-is/fimc-is-regs.c b/drivers/media/platform/exynos4-is/fimc-is-regs.c
index 63c68ec..42f2925 100644
--- a/drivers/media/platform/exynos4-is/fimc-is-regs.c
+++ b/drivers/media/platform/exynos4-is/fimc-is-regs.c
@@ -236,7 +236,7 @@ int fimc_is_itf_mode_change(struct fimc_is *is)
 	fimc_is_hw_change_mode(is);
 	ret = fimc_is_wait_event(is, IS_ST_CHANGE_MODE, 1,
 				FIMC_IS_CONFIG_TIMEOUT);
-	if (!ret < 0)
+	if (ret < 0)
 		dev_err(&is->pdev->dev, "%s(): mode change (%d) timeout\n",
 			__func__, is->config_index);
 	return ret;
