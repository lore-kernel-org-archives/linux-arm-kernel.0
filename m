From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 13 Mar 2013 13:36:01 +0800
Subject: [PATCH] mmc: vt8500: use resource_size() macro
Message-ID: <CAPgLHd8h9cKyqd7NGk5eaGYPMqauEcZ1agiDmk5ih2FjGcjgcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use resource_size function on resource object
instead of explicit computation.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/wmt-sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index c6d0015..04102d2 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -925,7 +925,7 @@ static int wmt_mci_remove(struct platform_device *pdev)
 	clk_put(priv->clk_sdmmc);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 
 	mmc_free_host(mmc);
 
