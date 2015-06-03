From: hramrach@gmail.com (Michal Suchanek)
Date: 3 Jun 2015 21:26:40 -0000
Subject: [PATCH 02/11] mtd: spi-nor: Add GD25LQ32C 1.8V SPI NOR flash ID
In-Reply-To: <cover.1433364398.git.hramrach@gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
Message-ID: <d96c00e9007a13819719af96094b258d77df4bde.1433364398.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This 1.8V SPI NOR flash is found on ARM Chromebook XE303C and reads
something like 25LQ32VIG in the middle.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 14a5d23..7bcc584 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -552,6 +552,7 @@ static const struct spi_device_id spi_nor_ids[] = {
 
 	/* GigaDevice */
 	{ "gd25q32", INFO(0xc84016, 0, 64 * 1024,  64, SECT_4K) },
+	{ "gd25lq32c", INFO(0xc86016, 0, 64 * 1024,  64, SECT_4K) },
 	{ "gd25q64", INFO(0xc84017, 0, 64 * 1024, 128, SECT_4K) },
 	{ "gd25q128", INFO(0xc84018, 0, 64 * 1024, 256, SECT_4K) },
 
-- 
2.1.4
