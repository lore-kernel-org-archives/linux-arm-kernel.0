From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 19 Jun 2017 11:18:02 +0530
Subject: [PATCH v2] soc: ti: knav_dma: make of_device_ids const.
Message-ID: <1045459264f851ecf3ea8d21bc1594dec79eb337.1497851119.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   2234	    608	      8	   2850	    b22	drivers/soc/ti/knav_dma.o

File size after constify keystone_qmss_of_match.
   text	   data	    bss	    dec	    hex	filename
   2650	    192	      8	   2850	    b22	drivers/soc/ti/knav_dma.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
Changes in v1:
              Subject was wrong. It should be constify of_match.

 drivers/soc/ti/knav_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index ecebe2e..c8d1e3c 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -791,7 +791,7 @@ static int knav_dma_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id of_match[] = {
+static const struct of_device_id of_match[] = {
 	{ .compatible = "ti,keystone-navigator-dma", },
 	{},
 };
-- 
1.9.1
