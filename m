From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 31 Aug 2010 14:12:11 +0200
Subject: [PATCH 09/12] DMAENGINE: remove pointless module safeguard on PL08X
In-Reply-To: <1283256734-3408-9-git-send-email-linus.walleij@stericsson.com>
References: <1283256734-3408-1-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-2-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-3-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-4-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-5-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-6-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-7-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-8-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-9-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1283256734-3408-10-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL08X driver safeguards itself from being compiled as a module
for no reason: the Kconfig option is a bool anyway.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/dma/amba-pl08x.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index a7ce08e..f80fc4b 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -130,18 +130,6 @@ struct pl08x_driver_data {
 	spinlock_t lock;
 };
 
-#ifdef MODULE
-
-# error "AMBA PL08X DMA CANNOT BE COMPILED AS A LOADABLE MODULE AT PRESENT"
-
-/*
-	a) Some devices might make use of DMA during boot
-	   (esp true for DMAENGINE implementation)
-	b) Memory allocation will need much more attention
-	   before load/unload can be supported
- */
-#endif
-
 /*
  * PL08X specific defines
  */
-- 
1.6.3.3
