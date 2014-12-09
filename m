From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Tue,  9 Dec 2014 21:13:23 +0800
Subject: [PATCH -next] coresight-tpiu: use module_amba_driver to simplify the
 code
Message-ID: <1418130803-27443-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

module_amba_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/coresight/coresight-tpiu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/coresight/coresight-tpiu.c b/drivers/coresight/coresight-tpiu.c
index ae10108..3b33af2 100644
--- a/drivers/coresight/coresight-tpiu.c
+++ b/drivers/coresight/coresight-tpiu.c
@@ -201,17 +201,7 @@ static struct amba_driver tpiu_driver = {
 	.id_table	= tpiu_ids,
 };
 
-static int __init tpiu_init(void)
-{
-	return amba_driver_register(&tpiu_driver);
-}
-module_init(tpiu_init);
-
-static void __exit tpiu_exit(void)
-{
-	amba_driver_unregister(&tpiu_driver);
-}
-module_exit(tpiu_exit);
+module_amba_driver(tpiu_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CoreSight Trace Port Interface Unit driver");
