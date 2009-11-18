From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Nov 2009 11:21:41 -0800
Subject: [PATCH 09/10] omap: mailbox: OMAP4 Mailbox Patch to change the IRQ
	flag from IRQF_DISABLED to IRQF_SHARED
In-Reply-To: <20091118191852.31148.93980.stgit@localhost>
References: <20091118191852.31148.93980.stgit@localhost>
Message-ID: <20091118192141.31148.59964.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: C A Subramaniam <subramaniam.ca@ti.com>

Currently, this facilitates both the tesla and ducati
sides to request for the same irq through an
omap_mbox_get() call.

Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mailbox.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 2210c45..4d7947e 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -284,7 +284,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 		write_unlock(&mboxes_lock);
 	}
 
-	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_DISABLED,
+	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
 				mbox->name, mbox);
 	if (unlikely(ret)) {
 		printk(KERN_ERR
