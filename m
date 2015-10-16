From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 16 Oct 2015 14:38:55 +0530
Subject: [PATCH v2 2/4] mtd: nand: Allow MTD_NAND_BRCMNAND to be selected for
 ARM64
In-Reply-To: <1444986537-28387-1-git-send-email-anup.patel@broadcom.com>
References: <1444986537-28387-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1444986537-28387-3-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BRCM NAND driver can be re-used for Broadcom ARM64 SoCs hence
this patch updates Kconfig to allow selection of MTD_NAND_BRCMNAND
for ARM64.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Pramod KUMAR <pramodku@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/mtd/nand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 3324281..a1b5819 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -393,7 +393,7 @@ config MTD_NAND_GPMI_NAND
 
 config MTD_NAND_BRCMNAND
 	tristate "Broadcom STB NAND controller"
-	depends on ARM || MIPS
+	depends on ARM || ARM64 || MIPS
 	help
 	  Enables the Broadcom NAND controller driver. The controller was
 	  originally designed for Set-Top Box but is used on various BCM7xxx,
-- 
1.9.1
