From: vthakkar1994@gmail.com (Vaishali Thakkar)
Date: Fri, 10 Jul 2015 01:29:44 +0530
Subject: [PATCH v2] coresight: replicator: Use module_platform_driver
Message-ID: <20150709195944.GA4470@vaishali-Ideapad-Z570>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use module_platform_driver for drivers whose init and exit functions
only register and unregister, respectively.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
Changes since v1:
	- As per Mathieu's suggestion, remove the comment and
          code of Coccinelle
	- Also, add blank line before module_platform_driver
---
 drivers/hwtracing/coresight/coresight-replicator.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 7974b7c..9c18bb5 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -184,17 +184,7 @@ static struct platform_driver replicator_driver = {
 	},
 };
 
-static int __init replicator_init(void)
-{
-	return platform_driver_register(&replicator_driver);
-}
-module_init(replicator_init);
-
-static void __exit replicator_exit(void)
-{
-	platform_driver_unregister(&replicator_driver);
-}
-module_exit(replicator_exit);
+module_platform_driver(replicator_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CoreSight Replicator driver");
-- 
1.9.1
