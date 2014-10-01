From: rogerq@ti.com (Roger Quadros)
Date: Wed, 1 Oct 2014 14:33:30 +0300
Subject: [PATCH 2/2] mtd: nand: omap: Correct CONFIG_MTD_NAND_OMAP_BCH help
 message
In-Reply-To: <1412163210-12948-1-git-send-email-rogerq@ti.com>
References: <1412163210-12948-1-git-send-email-rogerq@ti.com>
Message-ID: <1412163210-12948-3-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MTD_NAND_OMAP_BCH doesn't harm on legacy OMAP platforms
so don't state that it should be disabled for them.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mtd/nand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 1cb4b1b..dd10646 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -104,7 +104,7 @@ config MTD_NAND_OMAP_BCH
 	  locate and correct errors when using BCH ECC scheme. This offloads
 	  the cpu from doing ECC error searching and correction. However some
 	  legacy OMAP families like OMAP2xxx, OMAP3xxx do not have ELM engine
-	  so they should not enable this config symbol.
+	  so this is optional for them.
 
 config MTD_NAND_OMAP_BCH_BUILD
 	def_tristate MTD_NAND_OMAP2 && MTD_NAND_OMAP_BCH
-- 
1.8.3.2
