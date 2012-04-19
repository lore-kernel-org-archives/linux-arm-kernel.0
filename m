From: hong.xu@atmel.com (Hong Xu)
Date: Thu, 19 Apr 2012 10:33:39 +0800
Subject: [PATCH] MTD: AT91: Update atmel_nand_data to support PMECC
Message-ID: <1334802819-30428-1-git-send-email-hong.xu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added two items,
* correction_cap: PMECC correction capability
* sector_size:    Sector size for PMECC

Signed-off-by: Hong Xu <hong.xu@atmel.com>
---
 include/linux/platform_data/atmel.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index b0f2c56..4d9bfd5 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -20,6 +20,8 @@ struct atmel_nand_data {
 	u8		bus_width_16;		/* buswidth is 16 bit */
 	u8		ecc_mode;		/* ecc mode */
 	u8		on_flash_bbt;		/* bbt on flash */
+	u8		correction_cap;		/* PMECC capability */
+	u16		sector_size;		/* Sector size for PMECC */
 	struct mtd_partition *parts;
 	unsigned int	num_parts;
 };
-- 
1.7.10
