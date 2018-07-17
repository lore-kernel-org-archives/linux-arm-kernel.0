From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Tue, 17 Jul 2018 19:28:31 +0300
Subject: [PATCH 3/3] mtd: spi-nor: add support for Microchip SST26 QSPI flash
 memories
In-Reply-To: <20180717162831.17947-1-tudor.ambarus@microchip.com>
References: <20180717162831.17947-1-tudor.ambarus@microchip.com>
Message-ID: <20180717162831.17947-3-tudor.ambarus@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flash memories are write-protected by default at power-on and
must be unlocked first, before being erased, then programmed.

The erase block sizes are not uniform. The memory layout is uniform
just for the 4K sector blocks.

Based on initial work done by Cyrille Pitchen.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index eddf09f..06d7023 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1164,10 +1164,30 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "sst25wf040",  INFO(0xbf2504, 0, 64 * 1024,  8, SECT_4K | SST_WRITE) },
 	{ "sst25wf080",  INFO(0xbf2505, 0, 64 * 1024, 16, SECT_4K | SST_WRITE) },
 	{
+		"sst26vf016b", INFO(0xbf2641, 0, 64 * 1024, 32,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			UNLOCK_GLOBAL_BLOCK)
+	},
+	{
+		"sst26vf032b", INFO(0xbf2642, 0, 64 * 1024, 64,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			UNLOCK_GLOBAL_BLOCK)
+	},
+	{
 		"sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			UNLOCK_GLOBAL_BLOCK)
 	},
+	{
+		"sst26vf040b", INFO(0xbf2654, 0, 64 * 1024, 8,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			UNLOCK_GLOBAL_BLOCK)
+	},
+	{
+		"sst26vf080b", INFO(0xbf2658, 0, 64 * 1024, 16,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			UNLOCK_GLOBAL_BLOCK)
+	},
 
 	/* ST Microelectronics -- newer production may have feature updates */
 	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2, 0) },
-- 
2.9.4
