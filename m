From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Tue,  9 Dec 2014 21:12:58 +0800
Subject: [PATCH -next] coresight-funnel: use module_amba_driver to simplify
 the code
Message-ID: <1418130778-26900-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

module_amba_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/coresight/coresight-funnel.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/coresight/coresight-funnel.c b/drivers/coresight/coresight-funnel.c
index 2108edf..3db36f7 100644
--- a/drivers/coresight/coresight-funnel.c
+++ b/drivers/coresight/coresight-funnel.c
@@ -252,17 +252,7 @@ static struct amba_driver funnel_driver = {
 	.id_table	= funnel_ids,
 };
 
-static int __init funnel_init(void)
-{
-	return amba_driver_register(&funnel_driver);
-}
-module_init(funnel_init);
-
-static void __exit funnel_exit(void)
-{
-	amba_driver_unregister(&funnel_driver);
-}
-module_exit(funnel_exit);
+module_amba_driver(funnel_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CoreSight Funnel driver");
