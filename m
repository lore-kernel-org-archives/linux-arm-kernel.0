From: mnalajal@codeaurora.org (Murali Nalajala)
Date: Tue,  8 Mar 2011 05:38:55 +0530
Subject: [PATCH V2 1/2] mtd: nand: Allow NAND chip ids to be included
	standalone.
Message-ID: <1299542935-20291-1-git-send-email-mnalajal@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets non-standard NAND drivers take advantage of known NAND
chip information.

The initial development of msm nand driver, driver uses the supported
NAND devices information as a hardcoded table. Remove the existing
hardcoded supported flash device table and read the flash device
information from the flash id table which are part of the mtd subsystem.

Signed-off-by: Dima Zavin <dima@android.com>
Signed-off-by: Murali Nalajala <mnalajal@codeaurora.org>
---
Changes in V2
* Add more description to the commit text.

 drivers/mtd/nand/Kconfig |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index c895922..782275e 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -1,3 +1,10 @@
+config MTD_NAND_IDS
+	tristate "Include chip ids for known NAND devices."
+	depends on MTD
+	help
+	  Useful for NAND drivers that do not use the NAND subsystem but
+	  still like to take advantage of the known chip information.
+
 config MTD_NAND_ECC
 	tristate
 
@@ -123,9 +130,6 @@ config MTD_NAND_OMAP_PREFETCH_DMA
 	 or in DMA interrupt mode.
 	 Say y for DMA mode or MPU mode will be used
 
-config MTD_NAND_IDS
-	tristate
-
 config MTD_NAND_RICOH
 	tristate "Ricoh xD card reader"
 	default n
-- 
1.7.1.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
