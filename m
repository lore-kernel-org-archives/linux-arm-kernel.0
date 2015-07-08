From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Wed,  8 Jul 2015 16:21:20 -0400
Subject: [PATCH v1 6/7] mtd: spi-nor: Add support for Micron MT25QL02GC serial
 flash.
In-Reply-To: <1436386881-28088-1-git-send-email-cory.tusar@pid1solutions.com>
References: <1436386881-28088-1-git-send-email-cory.tusar@pid1solutions.com>
Message-ID: <1436386881-28088-7-git-send-email-cory.tusar@pid1solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Micron (mt25ql02gc) 256 MiB flash to the list of supported devices.

Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d78831b..7a8896d 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -596,6 +596,7 @@ static const struct spi_device_id spi_nor_ids[] = {
 	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
 	{ "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
 	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
+	{ "mt25ql02gc",  INFO(0x20ba22, 0, 64 * 1024, 4096, SPI_NOR_QUAD_READ) },
 
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
-- 
2.3.6
