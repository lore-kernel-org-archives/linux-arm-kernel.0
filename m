From: broonie@linaro.org (Mark Brown)
Date: Wed, 19 Jun 2013 19:21:21 +0100
Subject: [PATCH] spi/s3c64xx: Make wait_for_timeout() function name less
 generic
Message-ID: <1371666081-11699-1-git-send-email-broonie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 0a80692..70b2213 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -583,7 +583,7 @@ static inline void enable_cs(struct s3c64xx_spi_driver_data *sdd,
 	writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
 }
 
-static u32 wait_for_timeout(struct s3c64xx_spi_driver_data *sdd,
+static u32 s3c64xx_spi_wait_for_timeout(struct s3c64xx_spi_driver_data *sdd,
 					int timeout_ms)
 {
 	void __iomem *regs = sdd->regs;
@@ -676,7 +676,8 @@ static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
 		buf = xfer->rx_buf;
 		do {
 			/* wait for data to be received in the fifo */
-			cpy_len = wait_for_timeout(sdd, (loops ? ms : 0));
+			cpy_len = s3c64xx_spi_wait_for_timeout(sdd,
+						(loops ? ms : 0));
 
 			switch (sdd->cur_bpw) {
 			case 32:
-- 
1.8.3.1
