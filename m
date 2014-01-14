From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 14 Jan 2014 10:05:42 +0800
Subject: [PATCH -next] clk: exynos-audss: remove redundant dev_err call in
 exynos_audss_clk_probe()
Message-ID: <CAPgLHd9A8QjVk8ThLbP8vv8wMmJ-DovvR+=uadTXWyTFJok_JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/clk/samsung/clk-exynos-audss.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index 884187f..01ef381 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -94,10 +94,8 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(reg_base)) {
-		dev_err(&pdev->dev, "failed to map audss registers\n");
+	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);
-	}
 
 	clk_table = devm_kzalloc(&pdev->dev,
 				sizeof(struct clk *) * EXYNOS_AUDSS_MAX_CLKS,
