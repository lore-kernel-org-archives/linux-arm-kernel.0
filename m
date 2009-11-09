From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon,  9 Nov 2009 21:43:07 +0100
Subject: [PATCH] Use ST vendor enum instead of numeral
Message-ID: <1257799387-12335-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a leftover instance of using the 0x80 numeral instead
of the new AMBA_VENDOR_ST enum in the MMCI/PL180 driver.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 705a589..90d168a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -56,7 +56,7 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 				clk = 255;
 			host->cclk = host->mclk / (2 * (clk + 1));
 		}
-		if (host->hw_designer == 0x80)
+		if (host->hw_designer == AMBA_VENDOR_ST)
 			clk |= MCI_FCEN; /* Bug fix in ST IP block */
 		clk |= MCI_CLK_ENABLE;
 		/* This hasn't proven to be worthwhile */
-- 
1.6.3.3
