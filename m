From: broonie@kernel.org (Mark Brown)
Date: Wed, 04 Jan 2017 18:37:33 +0000
Subject: Applied "spi: armada-3700: Coding style fixes" to the spi tree
In-Reply-To: <20161221101030.10925-2-romain.perier@free-electrons.com>
Message-ID: <E1cOqRJ-00024z-MY@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: armada-3700: Coding style fixes

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 85798e153e6c3834ab2d69ee9d4db7d85f13809d Mon Sep 17 00:00:00 2001
From: Romain Perier <romain.perier@free-electrons.com>
Date: Wed, 21 Dec 2016 11:10:29 +0100
Subject: [PATCH] spi: armada-3700: Coding style fixes

The following warning are reported by checkpatch.pl:

CHECK: Alignment should match open parenthesis
+static void a3700_spi_transfer_setup(struct spi_device *spi,
+                                   struct spi_transfer *xfer)

WARNING: Missing a blank line after declarations
+                       u32 data = le32_to_cpu(val);
+                       memcpy(a3700_spi->rx_buf, &data, 4);

total: 0 errors, 1 warnings, 1 checks, 923 lines checked

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-armada-3700.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 9bee56ddff39..0baa69325e78 100644
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
2.11.0
