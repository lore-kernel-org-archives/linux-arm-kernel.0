From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Sun, 20 Jul 2014 22:02:04 +0800
Subject: [PATCH -next] spi/rockchip: fix error return code in
 rockchip_spi_probe()
Message-ID: <1405864924-14137-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -EINVAL from the error handling case instead of 0 when
failed to get fifo length.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/spi/spi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index cb8fd6f..8392ff5 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -642,6 +642,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	rs->fifo_len = get_fifo_len(rs);
 	if (!rs->fifo_len) {
 		dev_err(&pdev->dev, "Failed to get fifo length\n");
+		ret = -EINVAL;
 		goto err_get_fifo_len;
 	}
 
