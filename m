From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 14 Dec 2011 13:48:32 +0200
Subject: [PATCH 4/7] remoteproc/omap: utilize module_platform_driver
In-Reply-To: <1323863315-8159-1-git-send-email-ohad@wizery.com>
References: <1323863315-8159-1-git-send-email-ohad@wizery.com>
Message-ID: <1323863315-8159-5-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ditch some boilerplate code by employing the module_platform_driver
helper.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/remoteproc/omap_remoteproc.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index b49ecbb..aa3ce52 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -232,18 +232,7 @@ static struct platform_driver omap_rproc_driver = {
 	},
 };
 
-/* most of the below will go when module_platform_driver is merged */
-static int __init omap_rproc_init(void)
-{
-	return platform_driver_register(&omap_rproc_driver);
-}
-module_init(omap_rproc_init);
-
-static void __exit omap_rproc_exit(void)
-{
-	platform_driver_unregister(&omap_rproc_driver);
-}
-module_exit(omap_rproc_exit);
+module_platform_driver(omap_rproc_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("OMAP Remote Processor control driver");
-- 
1.7.5.4
