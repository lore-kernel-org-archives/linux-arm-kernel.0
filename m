From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 16 Feb 2011 09:40:26 +0100
Subject: [PATCH] spi/pl022: rid dangling labels
Message-ID: <1297845626-13332-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Remove a compilation error regarding unused labels that came about
when simplifying the DMA code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/amba-pl022.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 4cd05cc..14a451b 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -1030,8 +1030,6 @@ static int configure_dma(struct pl022 *pl022)
 
 	return 0;
 
-err_submit_tx:
-err_submit_rx:
 err_txdesc:
 	dmaengine_terminate_all(txchan);
 err_rxdesc:
-- 
1.7.3.2
