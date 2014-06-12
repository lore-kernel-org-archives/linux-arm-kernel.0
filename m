From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 12 Jun 2014 09:47:45 +0200
Subject: [PATCH] mmc: atmel-mci: add 0x600 IP version
Message-ID: <1402559265-18340-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 1b4b064..9c4c191 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2306,6 +2306,7 @@ static void __init atmci_get_cap(struct atmel_mci *host)
 
 	/* keep only major version number */
 	switch (version & 0xf00) {
+	case 0x600:
 	case 0x500:
 		host->caps.has_odd_clk_div = 1;
 	case 0x400:
-- 
1.7.9.5
