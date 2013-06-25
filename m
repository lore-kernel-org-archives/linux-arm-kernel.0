From: Baohua.Song@csr.com (Barry Song)
Date: Tue, 25 Jun 2013 19:45:29 +0800
Subject: [PATCH] spi: sirf: add missed spi mode_bits that SiRFSoC hardware
 supports
Message-ID: <1372160729-12796-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

Missing this will cause some user cases fail when they want to change spi
transfer mode.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 rebased to for-next branch of broonie/spi.git

 drivers/spi/spi-sirf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index fc20bcf..9608716 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -538,6 +538,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	sspi->bitbang.txrx_bufs = spi_sirfsoc_transfer;
 	sspi->bitbang.master->setup = spi_sirfsoc_setup;
 	master->bus_num = pdev->id;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_CS_HIGH;
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(12) |
 					SPI_BPW_MASK(16) | SPI_BPW_MASK(32);
 	sspi->bitbang.master->dev.of_node = pdev->dev.of_node;
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
