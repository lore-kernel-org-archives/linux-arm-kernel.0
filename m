From: ranjit.waghmode@xilinx.com (Ranjit Waghmode)
Date: Thu, 9 Jul 2015 18:14:55 +0530
Subject: [RFC PATCH 2/2] spi: zynqmp: gqspi: add support for stacked mode
 configuration
In-Reply-To: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <1436445895-25504-3-git-send-email-ranjit.waghmode@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support of stacked mode configuration for
Zynq Ultrascale+ MPSoC GQSPI controller driver.

Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 271fa80..6c9f7d9 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -410,6 +410,10 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 		zynqmp_gqspi_selectslave(xqspi,
 				GQSPI_SELECT_FLASH_CS_BOTH,
 				GQSPI_SELECT_FLASH_BUS_BOTH);
+	} else if (qspi->master->flags & SPI_MASTER_U_PAGE) {
+		zynqmp_gqspi_selectflash(xqspi,
+				GQSPI_SELECT_FLASH_CS_UPPER,
+				GQSPI_SELECT_FLASH_BUS_LOWER);
 	} else {
 		zynqmp_gqspi_selectslave(xqspi,
 				GQSPI_SELECT_FLASH_CS_LOWER,
--
2.1.2
