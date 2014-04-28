From: b32955@freescale.com (Huang Shijie)
Date: Mon, 28 Apr 2014 11:53:45 +0800
Subject: [PATCH v2 08/10] mtd: spi-nor: add more read transfer flags for
 n25q256a
In-Reply-To: <1398657227-20721-1-git-send-email-b32955@freescale.com>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
Message-ID: <1398657227-20721-9-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NOR flash can supports dual/quad/ddr-quad read.
Add more flags for these read transfers.

>From the datasheet, the chip support the 64K sector erase operation.
So remove the SECT_4K for the chip which makes the flash_erase faster.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/spi-nor/spi-nor.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index e0bc11a..07d249c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -500,7 +500,7 @@ const struct spi_device_id spi_nor_ids[] = {
 	{ "n25q064",     INFO(0x20ba17, 0, 64 * 1024,  128, 0) },
 	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, 0) },
 	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, 0) },
-	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K) },
+	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_DDR_QUAD_READ) },
 	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K) },
 
 	/* PMC */
-- 
1.7.2.rc3
