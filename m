From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 19 Sep 2011 14:51:29 +0200
Subject: [PATCH 05/11] at91/ide: use gpio_is_valid to check the gpio
In-Reply-To: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
References: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1316436695-19194-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-ide at vger.kernel.org
---
Hi,

	I'd like to apply this patch via AT91 with the whole gpio patch series

Best Regards,
J.
 drivers/ide/at91_ide.c |    2 +-
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
1.7.5.4
