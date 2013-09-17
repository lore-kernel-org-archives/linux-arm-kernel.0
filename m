From: jiri.prchal@aksignal.cz (Jiri Prchal)
Date: Tue, 17 Sep 2013 11:57:36 +0200
Subject: [PATCH] at91: mmc: fix minimum bus frequency
Message-ID: <1379411857-18516-1-git-send-email-jiri.prchal@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In datasheet is mmc bus frequency divided by n+2. Uppon this maximum division is 513.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 drivers/mmc/host/atmel-mci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 69e438e..f61bbf6 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2145,7 +2145,7 @@ static int __init atmci_init_slot(struct atmel_mci *host,
 		slot_data->wp_pin);
 
 	mmc->ops = &atmci_ops;
-	mmc->f_min = DIV_ROUND_UP(host->bus_hz, 512);
+	mmc->f_min = DIV_ROUND_UP(host->bus_hz, 513);
 	mmc->f_max = host->bus_hz / 2;
 	mmc->ocr_avail	= MMC_VDD_32_33 | MMC_VDD_33_34;
 	if (sdio_irq)
-- 
1.7.9.5
