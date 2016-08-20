From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sat, 20 Aug 2016 15:30:16 +0000
Subject: [PATCH -next] MMC: meson: remove redundant return value check of
 platform_get_resource()
Message-ID: <1471707016-28957-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unneeded error handling on the result of a call
to platform_get_resource() when the value is passed to
devm_ioremap_resource().

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/mmc/host/meson-gxbb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gxbb.c b/drivers/mmc/host/meson-gxbb.c
index 10eac41..96cd883 100644
--- a/drivers/mmc/host/meson-gxbb.c
+++ b/drivers/mmc/host/meson-gxbb.c
@@ -811,10 +811,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret = -ENODEV;
-		goto free_host;
-	}
 	host->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(host->regs)) {
 		ret = PTR_ERR(host->regs);
