From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Mon, 28 Sep 2009 09:21:26 -0700
Subject: [PATCH] omap: mailbox: Fix wrong condition check in while loop
Message-ID: <mailman.43.1254155229.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's worked fine so far since reset is done for the first time.

Reported-by: Juha Leppanen <juha_motorsportcom@luukku.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Juha Leppanen <juha_motorsportcom@luukku.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index f3fefca..c035ad3 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -93,7 +93,7 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 		l = mbox_read_reg(MAILBOX_SYSSTATUS);
 		if (l & RESETDONE)
 			break;
-	} while (time_after(jiffies, timeout));
+	} while (!time_after(jiffies, timeout));
 
 	if (!(l & RESETDONE)) {
 		pr_err("Can't take mmu out of reset\n");

--6c2NcOVqGQ03X4Wi--
