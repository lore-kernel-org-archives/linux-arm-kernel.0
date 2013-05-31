From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Jun 2013 00:22:39 +0200
Subject: [PATCH 02/15] mtd: omap2: allow bulding as a module
In-Reply-To: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
Message-ID: <1370038972-2318779-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omap2 nand device driver calls into the the elm code, which can
be a loadable module, and in that case it cannot be built-in itself.
I can see no reason why the omap2 driver cannot also be a module,
so let's make the option "tristate" in Kconfig to fix this allmodconfig
build error:

ERROR: "elm_config" [drivers/mtd/nand/omap2.ko] undefined!
ERROR: "elm_decode_bch_error_page" [drivers/mtd/nand/omap2.ko] undefined!

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Tony Lindgren <tony@atomide.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Afzal Mohammed <afzal@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-mtd at lists.infradead.org
---
 drivers/mtd/nand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 3ae9105..5ef8f5e 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -95,7 +95,7 @@ config MTD_NAND_OMAP2
 
 config MTD_NAND_OMAP_BCH
 	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
-	bool "Enable support for hardware BCH error correction"
+	tristate "Enable support for hardware BCH error correction"
 	default n
 	select BCH
 	select BCH_CONST_PARAMS
-- 
1.8.1.2
