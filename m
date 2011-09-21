From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Sep 2011 13:30:39 +0200
Subject: [PATCH 05/11 v2] ARM: at91/ide: use gpio_is_valid to check the gpio
In-Reply-To: <20110921112830.GP24966@game.jcrosoft.org>
References: <20110921112830.GP24966@game.jcrosoft.org>
Message-ID: <1316604645-22599-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
V2 update commit log

Best Regards,
J. drivers/ide/at91_ide.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
index 000a78e..ba2eda3 100644
--- a/drivers/ide/at91_ide.c
+++ b/drivers/ide/at91_ide.c
@@ -314,7 +314,7 @@ static int __init at91_ide_probe(struct platform_device *pdev)
 	apply_timings(board->chipselect, 0, ide_timing_find_mode(XFER_PIO_0), 0);
 
 	/* with GPIO interrupt we have to do quirks in handler */
-	if (board->irq_pin >= PIN_BASE)
+	if (gpio_is_valid(board->irq_pin))
 		host->irq_handler = at91_irq_handler;
 
 	host->ports[0]->select_data = board->chipselect;
-- 
1.7.6.3
