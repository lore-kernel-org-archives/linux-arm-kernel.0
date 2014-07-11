From: addy.ke@rock-chips.com (Addy Ke)
Date: Fri, 11 Jul 2014 10:08:51 +0800
Subject: [PATCH 3/4] spi/rockchip: master->mode_bits: remove SPI_CS_HIGH bit
In-Reply-To: <1405044389-6800-1-git-send-email-addy.ke@rock-chips.com>
References: <1405044389-6800-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1405044531-6963-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Addy Ke <addy.ke@rockchip.com>

Suggested-by: Jonas Gorski <jogo@openwrt.org>
Signed-off-by: Addy Ke <addy.ke@rockchip.com>
---
 drivers/spi/spi-rockchip.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 09c690c..a8866c9 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -295,11 +295,6 @@ static int rockchip_spi_prepare_message(struct spi_master *master,
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 	struct spi_device *spi = msg->spi;
 
-	if (spi->mode & SPI_CS_HIGH) {
-		dev_err(rs->dev, "spi_cs_hign: not support\n");
-		return -EINVAL;
-	}
-
 	rs->mode = spi->mode;
 
 	return 0;
@@ -657,7 +652,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	master->auto_runtime_pm = true;
 	master->bus_num = pdev->id;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
 	master->num_chipselect = 2;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
-- 
1.8.3.2
