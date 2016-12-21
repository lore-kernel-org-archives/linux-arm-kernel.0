From: romain.perier@free-electrons.com (Romain Perier)
Date: Wed, 21 Dec 2016 11:10:30 +0100
Subject: [PATCH 2/2] spi: armada-3700: Replaced raw values for nbits by the
 SPI macros
In-Reply-To: <20161221101030.10925-1-romain.perier@free-electrons.com>
References: <20161221101030.10925-1-romain.perier@free-electrons.com>
Message-ID: <20161221101030.10925-3-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, function a3700_spi_pin_mode_set() configures the SPI transfer
mode according to the value passed as second argument. This value is
detected using the raw values from a switch case.

This commit replaces these raw values by the corresponding macro
constants in linux/spi/spi.h

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
 drivers/spi/spi-armada-3700.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 0bfe5ff..e598421 100644
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
2.9.3
