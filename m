From: b32955@freescale.com (Huang Shijie)
Date: Fri, 30 Dec 2011 12:45:37 +0800
Subject: [PATCH] MTD/GPMI : select more modules for GPMI by default
Message-ID: <1325220337-23165-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpmi-nand driver needs the mxs-dma driver. So select the
MXS_DMA by default. So does the MTD_CHAR.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 07c4774..1b14a3a 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -420,6 +420,8 @@ config MTD_NAND_NANDSIM
 config MTD_NAND_GPMI_NAND
         bool "GPMI NAND Flash Controller driver"
         depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28)
+	select MXS_DMA
+	select MTD_CHAR
 	select MTD_PARTITIONS
 	select MTD_CMDLINE_PARTS
         help
-- 
1.7.0.4
