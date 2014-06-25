From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Wed, 25 Jun 2014 16:08:16 +0530
Subject: [PATCH 1/2] i2c: exynos5: remove an unnecessary read of FIFO_STATUS
 register
Message-ID: <1403692697-7381-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes an extra read of FIFO_STATUS register in the interrrupt
service routine. Which is read again before the actual use.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 drivers/i2c/busses/i2c-exynos5.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index 63d2292..0d1a7bc 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -405,7 +405,6 @@ static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
 
 	int_status = readl(i2c->regs + HSI2C_INT_STATUS);
 	writel(int_status, i2c->regs + HSI2C_INT_STATUS);
-	fifo_status = readl(i2c->regs + HSI2C_FIFO_STATUS);
 
 	/* handle interrupt related to the transfer status */
 	if (int_status & HSI2C_INT_I2C) {
-- 
1.7.9.5
