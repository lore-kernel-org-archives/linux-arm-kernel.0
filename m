From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 5 Apr 2016 13:59:38 +0800
Subject: [PATCH v3 10/14] bus: imx-weim: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1459835982-26473-11-git-send-email-wangkefeng.wang@huawei.com>
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
index 1827fc4..4bd361d 100644
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
