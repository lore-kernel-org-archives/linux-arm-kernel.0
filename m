From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri,  9 Jan 2015 16:57:14 -0700
Subject: [PATCH 03/11] coresight-funnel: use module_amba_driver to simplify
 the code
In-Reply-To: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
References: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1420847842-31769-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

module_amba_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/coresight-funnel.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/coresight/coresight-funnel.c b/drivers/coresight/coresight-funnel.c
index 2108edffe1f4..3db36f70b666 100644
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
-- 
1.9.1
