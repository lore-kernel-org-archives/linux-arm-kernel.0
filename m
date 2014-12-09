From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Tue,  9 Dec 2014 21:13:12 +0800
Subject: [PATCH -next] coresight-tmc: use module_amba_driver to simplify the
 code
Message-ID: <1418130792-27195-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

module_amba_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/coresight/coresight-tmc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/coresight/coresight-tmc.c b/drivers/coresight/coresight-tmc.c
index ce2c293..3ff232f 100644
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
