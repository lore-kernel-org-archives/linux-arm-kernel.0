From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri,  9 Jan 2015 16:57:15 -0700
Subject: [PATCH 04/11] coresight-tmc: use module_amba_driver to simplify the
 code
In-Reply-To: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
References: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1420847842-31769-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

module_amba_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/coresight-tmc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/coresight/coresight-tmc.c b/drivers/coresight/coresight-tmc.c
index ce2c293f1707..3ff232f9ddf7 100644
--- a/drivers/coresight/coresight-tmc.c
+++ b/drivers/coresight/coresight-tmc.c
@@ -760,17 +760,7 @@ static struct amba_driver tmc_driver = {
 	.id_table	= tmc_ids,
 };
 
-static int __init tmc_init(void)
-{
-	return amba_driver_register(&tmc_driver);
-}
-module_init(tmc_init);
-
-static void __exit tmc_exit(void)
-{
-	amba_driver_unregister(&tmc_driver);
-}
-module_exit(tmc_exit);
+module_amba_driver(tmc_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CoreSight Trace Memory Controller driver");
-- 
1.9.1
