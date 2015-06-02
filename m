From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  2 Jun 2015 19:32:29 +0200
Subject: [PATCH 5/7] mtd: nand: let Marvell Berlin SoCs select the pxa3xx
 driver
In-Reply-To: <1433266351-22587-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1433266351-22587-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1433266351-22587-6-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell Berlin nand controller support has been added in the pxa3xx nand
driver. Let these SoCs select the driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/mtd/nand/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 5897d8d8fa5a..0e41f2126e39 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -331,8 +331,8 @@ config MTD_NAND_ATMEL
 	  on Atmel AT91 and AVR32 processors.
 
 config MTD_NAND_PXA3xx
-	tristate "NAND support on PXA3xx and Armada 370/XP"
-	depends on PXA3xx || ARCH_MMP || PLAT_ORION
+	tristate "NAND support on PXA3xx, Armada 370/XP and Marvell Berlin"
+	depends on PXA3xx || ARCH_MMP || PLAT_ORION || ARCH_BERLIN
 	help
 	  This enables the driver for the NAND flash device found on
 	  PXA3xx processors (NFCv1) and also on Armada 370/XP (NFCv2).
-- 
2.4.2
