From: hong.xu@atmel.com (Hong Xu)
Date: Thu,  8 Dec 2011 12:44:21 +0800
Subject: [PATCH] AT91: Update struct atmel_nand_data to support PMECC
Message-ID: <1323319461-19983-1-git-send-email-hong.xu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

User will use the newly added field `correction_cap' and
`sector_size' to pass PMECC parameters to driver.

Signed-off-by: Hong Xu <hong.xu@atmel.com>
---
 arch/arm/mach-at91/include/mach/board.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index eac92e9..b0035de 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -117,6 +117,8 @@ struct atmel_nand_data {
 	u8		ale;		/* address line number connected to ALE */
 	u8		cle;		/* address line number connected to CLE */
 	u8		bus_width_16;	/* buswidth is 16 bit */
+	u8		correction_cap; /* PMECC correction capability */
+	u16		sector_size;    /* Sector size for PMECC */
 	struct mtd_partition *parts;
 	unsigned int	num_parts;
 };
-- 
1.7.3.3
