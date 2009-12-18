From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Fri, 18 Dec 2009 16:52:04 +0100
Subject: [PATCH] spi: spi_imx: add device information to debug.
Message-ID: <1261151524.3356.57.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not an heavy fix, but good when debugging multiple spi channels.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 drivers/spi/spi_imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 89c22ef..18bbfa3 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -466,7 +466,7 @@ static int spi_imx_setup(struct spi_device *spi)
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	int gpio = spi_imx->chipselect[spi->chip_select];
 
-	pr_debug("%s: mode %d, %u bpw, %d hz\n", __func__,
+	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n", __func__,
 		 spi->mode, spi->bits_per_word, spi->max_speed_hz);
 
 	if (gpio >= 0)
-- 
1.6.3.3
