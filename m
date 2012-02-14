From: b32955@freescale.com (Huang Shijie)
Date: Tue, 14 Feb 2012 11:22:04 +0800
Subject: [PATCH] mtd/gpmi : fix compiler warning
Message-ID: <1329189724-26100-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpmi driver selects the MTD_CMDLINE_PARTS directly.
But we should not select a visible symbol.

Just remove the select.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 2474733..7612eae 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -440,7 +440,6 @@ config MTD_NAND_NANDSIM
 config MTD_NAND_GPMI_NAND
         bool "GPMI NAND Flash Controller driver"
         depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28)
-	select MTD_CMDLINE_PARTS
         help
 	 Enables NAND Flash support for IMX23 or IMX28.
 	 The GPMI controller is very powerful, with the help of BCH
-- 
1.7.0.4
