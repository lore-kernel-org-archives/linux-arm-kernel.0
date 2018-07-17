From: maxime.chevallier@bootlin.com (Maxime Chevallier)
Date: Tue, 17 Jul 2018 16:31:50 +0200
Subject: [PATCH RESEND 1/5] spi: imx: Remove duplicate variable assignments
In-Reply-To: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
References: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
Message-ID: <20180717143154.28241-2-maxime.chevallier@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some fields in struct spi_imx_data are assigned a different value twice
in a row, in spi_imx_setupxfer.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/spi/spi-imx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index d3b21faf6b1f..d75153c995af 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1106,8 +1106,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	if (spi_imx->devtype_data->dynamic_burst && !spi_imx->slave_mode) {
 		u32 mask;
 
-		spi_imx->dynamic_burst = 0;
-		spi_imx->remainder = 0;
 		spi_imx->read_u32  = 1;
 
 		mask = (1 << spi_imx->bits_per_word) - 1;
-- 
2.11.0
