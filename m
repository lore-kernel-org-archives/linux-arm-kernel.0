From: stigge@antcom.de (Roland Stigge)
Date: Wed, 27 Jun 2012 17:51:14 +0200
Subject: [PATCH 3/4] mtd: lpc32xx_slc: Use of_get_named_gpio()
In-Reply-To: <1340812275-1197-1-git-send-email-stigge@antcom.de>
References: <1340812275-1197-1-git-send-email-stigge@antcom.de>
Message-ID: <1340812275-1197-3-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the lpc32xx_slc driver use of_get_named_gpio() instead of
of_get_named_gpio_flags() whose flags are discarded anyway.

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
---
 drivers/mtd/nand/lpc32xx_slc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index ab72aca..4e8db3a 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -770,7 +770,7 @@ static struct lpc32xx_nand_cfg_slc *lpc32xx_parse_dt(struct device *dev)
 	}
 
 	pdata->use_bbt = of_get_nand_on_flash_bbt(np);
-	pdata->wp_gpio = of_get_named_gpio_flags(np, "gpios", 0, NULL);
+	pdata->wp_gpio = of_get_named_gpio(np, "gpios", 0);
 
 	return pdata;
 }
-- 
1.7.10.4
