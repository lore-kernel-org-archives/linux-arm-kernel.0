From: h-kanigeri2@ti.com (Hari Kanigeri)
Date: Tue, 23 Nov 2010 15:26:55 -0600
Subject: [PATCH v4 3/5] OMAP: mailbox: fix checkpatch warnings
In-Reply-To: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
Message-ID: <1290547617-16640-4-git-send-email-h-kanigeri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following checkpatch warnings observed in mailbox module.

WARNING: please, no space for starting a line,
                                excluding comments
+ fail_alloc_rxq:$

WARNING: please, no space for starting a line,
                                excluding comments
+ fail_alloc_txq:$

WARNING: please, no space for starting a line,
                                excluding comments
+ fail_request_irq:$

WARNING: line over 80 characters
+       mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size, sizeof(mbox_msg_t));

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index a1c6bd9..13698ab 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -281,11 +281,11 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 
 	return 0;
 
- fail_alloc_rxq:
+fail_alloc_rxq:
 	mbox_queue_free(mbox->txq);
- fail_alloc_txq:
+fail_alloc_txq:
 	free_irq(mbox->irq, mbox);
- fail_request_irq:
+fail_request_irq:
 	if (mbox->ops->shutdown)
 		mbox->ops->shutdown(mbox);
 
@@ -400,7 +400,8 @@ static int __init omap_mbox_init(void)
 
 	/* kfifo size sanity check: alignment and minimal size */
 	mbox_kfifo_size = ALIGN(mbox_kfifo_size, sizeof(mbox_msg_t));
-	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size, sizeof(mbox_msg_t));
+	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size,
+							sizeof(mbox_msg_t));
 
 	return 0;
 }
-- 
1.7.0
