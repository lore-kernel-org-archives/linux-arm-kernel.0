From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Mon, 11 Apr 2016 10:23:03 +0530
Subject: [PATCH] clk: sunxi: Use resource_size
Message-ID: <1460350383-7661-1-git-send-email-vaishali.thakkar@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the function resource_size instaed of explicit computation.

Problem found using Coccinelle.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
---
 drivers/clk/sunxi/clk-sun9i-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sun9i-mmc.c b/drivers/clk/sunxi/clk-sun9i-mmc.c
index 028dd83..7167373 100644
--- a/drivers/clk/sunxi/clk-sun9i-mmc.c
+++ b/drivers/clk/sunxi/clk-sun9i-mmc.c
@@ -106,7 +106,7 @@ static int sun9i_a80_mmc_config_clk_probe(struct platform_device *pdev)
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	/* one clock/reset pair per word */
-	count = DIV_ROUND_UP((r->end - r->start + 1), SUN9I_MMC_WIDTH);
+	count = DIV_ROUND_UP((resource_size(r)), SUN9I_MMC_WIDTH);
 	data->membase = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(data->membase))
 		return PTR_ERR(data->membase);
-- 
2.1.4
