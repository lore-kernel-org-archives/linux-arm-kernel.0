From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Tue,  9 Dec 2014 21:12:39 +0800
Subject: [PATCH -next] coresight-etb: use module_amba_driver to simplify the
 code
Message-ID: <1418130759-25489-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

module_amba_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/coresight/coresight-etb10.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/coresight/coresight-etb10.c b/drivers/coresight/coresight-etb10.c
index c922d4a..a1da702 100644
--- a/drivers/coresight/coresight-etb10.c
+++ b/drivers/coresight/coresight-etb10.c
@@ -521,17 +521,7 @@ static struct amba_driver etb_driver = {
 	.id_table	= etb_ids,
 };
 
-static int __init etb_init(void)
-{
-	return amba_driver_register(&etb_driver);
-}
-module_init(etb_init);
-
-static void __exit etb_exit(void)
-{
-	amba_driver_unregister(&etb_driver);
-}
-module_exit(etb_exit);
+module_amba_driver(etb_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CoreSight Embedded Trace Buffer driver");
