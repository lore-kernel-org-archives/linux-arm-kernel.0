From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  5 Nov 2013 09:55:12 -0300
Subject: [PATCH v3 05/28] mtd: nand: pxa3xx: Make config menu show supported
 platforms
In-Reply-To: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383656135-8627-6-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have now support for the NFCv2 controller found on
Armada 370/XP platforms.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 93ae6a6..942ef28 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -326,11 +326,11 @@ config MTD_NAND_ATMEL
 	  on Atmel AT91 and AVR32 processors.
 
 config MTD_NAND_PXA3xx
-	tristate "Support for NAND flash devices on PXA3xx"
+	tristate "NAND support on PXA3xx and Armada 370/XP"
 	depends on PXA3xx || ARCH_MMP || PLAT_ORION
 	help
 	  This enables the driver for the NAND flash device found on
-	  PXA3xx processors
+	  PXA3xx processors (NFCv1) and also on Armada 370/XP (NFCv2).
 
 config MTD_NAND_SLC_LPC32XX
 	tristate "NXP LPC32xx SLC Controller"
-- 
1.8.1.5
