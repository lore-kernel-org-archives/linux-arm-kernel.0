From: broonie@kernel.org (Mark Brown)
Date: Wed, 04 Jan 2017 18:37:36 +0000
Subject: Applied "spi: armada-3700: Replaced raw values for nbits by the SPI
 macros" to the spi tree
In-Reply-To: <20161221101030.10925-3-romain.perier@free-electrons.com>
Message-ID: <E1cOqRM-000261-Mt@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: armada-3700: Replaced raw values for nbits by the SPI macros

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

>From cfd6693c06324174ceeac7aed570a0df67db7c4f Mon Sep 17 00:00:00 2001
From: Romain Perier <romain.perier@free-electrons.com>
Date: Wed, 21 Dec 2016 11:10:30 +0100
Subject: [PATCH] spi: armada-3700: Replaced raw values for nbits by the SPI
 macros

Currently, function a3700_spi_pin_mode_set() configures the SPI transfer
mode according to the value passed as second argument. This value is
detected using the raw values from a switch case.

This commit replaces these raw values by the corresponding macro
constants in linux/spi/spi.h

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-armada-3700.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 4e68f34957cc..9bee56ddff39 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -170,12 +170,12 @@ static int a3700_spi_pin_mode_set(struct a3700_spi *a3700_spi,
 	val &= ~(A3700_SPI_DATA_PIN0 | A3700_SPI_DATA_PIN1);
 
 	switch (pin_mode) {
-	case 1:
+	case SPI_NBITS_SINGLE:
 		break;
-	case 2:
+	case SPI_NBITS_DUAL:
 		val |= A3700_SPI_DATA_PIN0;
 		break;
-	case 4:
+	case SPI_NBITS_QUAD:
 		val |= A3700_SPI_DATA_PIN1;
 		break;
 	default:
-- 
2.11.0
