From: romain.perier@free-electrons.com (Romain Perier)
Date: Wed, 21 Dec 2016 11:10:29 +0100
Subject: [PATCH 1/2] spi: armada-3700: Coding style fixes
In-Reply-To: <20161221101030.10925-1-romain.perier@free-electrons.com>
References: <20161221101030.10925-1-romain.perier@free-electrons.com>
Message-ID: <20161221101030.10925-2-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following warning are reported by checkpatch.pl:

CHECK: Alignment should match open parenthesis
+static void a3700_spi_transfer_setup(struct spi_device *spi,
+                                   struct spi_transfer *xfer)

WARNING: Missing a blank line after declarations
+                       u32 data = le32_to_cpu(val);
+                       memcpy(a3700_spi->rx_buf, &data, 4);

total: 0 errors, 1 warnings, 1 checks, 923 lines checked

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
 drivers/spi/spi-armada-3700.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index ec5fb01..0bfe5ff 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -420,7 +420,7 @@ static void a3700_spi_fifo_thres_set(struct a3700_spi *a3700_spi,
 }
 
 static void a3700_spi_transfer_setup(struct spi_device *spi,
-				    struct spi_transfer *xfer)
+				     struct spi_transfer *xfer)
 {
 	struct a3700_spi *a3700_spi;
 	unsigned int byte_len;
@@ -561,6 +561,7 @@ static int a3700_spi_fifo_read(struct a3700_spi *a3700_spi)
 		val = spireg_read(a3700_spi, A3700_SPI_DATA_IN_REG);
 		if (a3700_spi->buf_len >= 4) {
 			u32 data = le32_to_cpu(val);
+
 			memcpy(a3700_spi->rx_buf, &data, 4);
 
 			a3700_spi->buf_len -= 4;
-- 
2.9.3
