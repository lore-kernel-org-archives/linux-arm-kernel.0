From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 20 Dec 2013 10:21:54 +0800
Subject: [PATCH -next] spi: nuc900: remove redundant return value check of
 platform_get_resource()
Message-ID: <CAPgLHd9rWo=vAa5xiPhi_FFheGNMOTEvt_0_AFaxMyYEJ8TBrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove unneeded error handling on the result of a call
to platform_get_resource() when the value is passed to
devm_ioremap_resource().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/spi/spi-nuc900.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
index 43d340c..5040630 100644
--- a/drivers/spi/spi-nuc900.c
+++ b/drivers/spi/spi-nuc900.c
@@ -368,12 +368,6 @@ static int nuc900_spi_probe(struct platform_device *pdev)
 	hw->bitbang.txrx_bufs      = nuc900_spi_txrx;
 
 	hw->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (hw->res == NULL) {
-		dev_err(&pdev->dev, "Cannot get IORESOURCE_MEM\n");
-		err = -ENOENT;
-		goto err_pdata;
-	}
-
 	hw->regs = devm_ioremap_resource(&pdev->dev, hw->res);
 	if (IS_ERR(hw->regs)) {
 		err = PTR_ERR(hw->regs);
