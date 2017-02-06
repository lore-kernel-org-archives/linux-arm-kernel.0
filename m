From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon,  6 Feb 2017 16:23:02 +0000
Subject: [PATCH -next] soc: zte: pm_domains: Remove redundant dev_err call in
 zx2967_pd_probe()
Message-ID: <20170206162302.15611-1-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/soc/zte/zx2967_pm_domains.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/zte/zx2967_pm_domains.c b/drivers/soc/zte/zx2967_pm_domains.c
index 61c8d84..c42aeaa 100644
--- a/drivers/soc/zte/zx2967_pm_domains.c
+++ b/drivers/soc/zte/zx2967_pm_domains.c
@@ -125,10 +125,8 @@ int zx2967_pd_probe(struct platform_device *pdev,
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pcubase = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pcubase)) {
-		dev_err(&pdev->dev, "ioremap fail.\n");
+	if (IS_ERR(pcubase))
 		return PTR_ERR(pcubase);
-	}
 
 	for (i = 0; i < domain_num; ++i) {
 		zx_pm_domains[i]->power_on = zx2967_power_on;
