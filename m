From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Fri, 16 Jun 2017 17:50:34 +0530
Subject: [PATCH] soc: ti: knav: make of_device_ids const.
Message-ID: <754c97ef359882e602affee9f6709dcd687a2234.1497615578.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   5369	    720	      8	   6097	   17d1	drivers/soc/ti/knav_qmss_queue.o

File size after constify keystone_qmss_of_match.
   text	   data	    bss	    dec	    hex	filename
   5785	    304	      8	   6097	   17d1	drivers/soc/ti/knav_qmss_queue.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 2ec3536..740639c 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1813,7 +1813,7 @@ static int knav_queue_remove(struct platform_device *pdev)
 }
 
 /* Match table for of_platform binding */
-static struct of_device_id keystone_qmss_of_match[] = {
+static const struct of_device_id keystone_qmss_of_match[] = {
 	{ .compatible = "ti,keystone-navigator-qmss", },
 	{},
 };
-- 
1.9.1
