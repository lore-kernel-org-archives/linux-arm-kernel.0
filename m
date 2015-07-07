From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  7 Jul 2015 17:27:25 +0200
Subject: [PATCH v2 5/7] mtd: nand: let Marvell Berlin SoCs select the pxa3xx
 driver
In-Reply-To: <1436282847-21137-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1436282847-21137-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1436282847-21137-6-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell Berlin nand controller support has been added in the pxa3xx nand
driver. Let these SoCs select the driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/mtd/nand/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 5b2806a7e5f7..84bb5479a4a9 100644
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
2.4.5
