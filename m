From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Wed, 17 Jan 2018 11:26:27 +0000
Subject: [PATCH -next] clk: samsung: exynos5433: Remove redundant dev_err call
 in exynos5433_cmu_probe()
Message-ID: <1516188387-144930-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index db27090..9323e6b 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -5513,10 +5513,8 @@ static int __init exynos5433_cmu_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(reg_base)) {
-		dev_err(dev, "failed to map registers\n");
+	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);
-	}
 
 	for (i = 0; i < info->nr_clk_ids; ++i)
 		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
