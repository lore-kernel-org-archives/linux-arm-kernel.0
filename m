From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Sun, 20 Jul 2014 22:01:42 +0800
Subject: [PATCH -next] spi/rockchip: remove redundant dev_err call in
 rockchip_spi_probe()
Message-ID: <1405864902-14056-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/spi/spi-rockchip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 72fb287..171353b 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -585,7 +585,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	rs->regs = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(rs->regs)) {
-		dev_err(&pdev->dev, "Failed to map SPI region\n");
 		ret =  PTR_ERR(rs->regs);
 		goto err_ioremap_resource;
 	}
