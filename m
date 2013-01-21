From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 17:16:04 +0000
Subject: [PATCH 11/15] mtd: davinci_nand: fix OF support
In-Reply-To: <1358788568-11137-1-git-send-email-arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
Message-ID: <1358788568-11137-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch cdeadd "mtd: nand: davinci: add OF support for
davinci nand controller" ironically causes a build error
when CONFIG_OF is enabled because of a missing ';'
character:

drivers/mtd/nand/davinci_nand.c:527:1: error: expected ',' or ';' before 'extern'

This is the obvious fix.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Schocher <hs@denx.de>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: David Woodhouse <David.Woodhouse@intel.com>
---
 drivers/mtd/nand/davinci_nand.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 3502606..feae55c 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -523,7 +523,7 @@ static struct nand_ecclayout hwecc4_2048 __initconst = {
 static const struct of_device_id davinci_nand_of_match[] = {
 	{.compatible = "ti,davinci-nand", },
 	{},
-}
+};
 MODULE_DEVICE_TABLE(of, davinci_nand_of_match);
 
 static struct davinci_nand_pdata
-- 
1.7.10.4
