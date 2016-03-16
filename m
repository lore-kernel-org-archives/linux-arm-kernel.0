From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 16 Mar 2016 15:35:39 +0800
Subject: [PATCH v2 all 10/14] bus: imx-weim: use
 of_platform_default_populate() to populate default bus
In-Reply-To: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1458113743-15131-11-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Acked-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Signed-off-by: Huang Shijie <b32955@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/bus/imx-weim.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index e98d15e..79a4fa3 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -163,9 +163,8 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 	}
 
 	if (have_child)
-		ret = of_platform_populate(pdev->dev.of_node,
-				   of_default_bus_match_table,
-				   NULL, &pdev->dev);
+		ret = of_platform_default_populate(pdev->dev.of_node,
+						   NULL, &pdev->dev);
 	if (ret)
 		dev_err(&pdev->dev, "%s fail to create devices.\n",
 			pdev->dev.of_node->full_name);
-- 
2.6.0.GIT
