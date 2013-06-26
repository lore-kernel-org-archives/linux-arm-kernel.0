From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 26 Jun 2013 11:27:35 +0200
Subject: [PATCH] ARM: ARMv7-M: Fix name of NVIC handler function
Message-ID: <1372238855-26112-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The name changed in response to review comments for the nvic irqchip
driver when the original name was already accepted into Russell King's
tree.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

this patch was part of the irqchip patch v4, but I split it out for
being easier to merge in v5. It applies on top of Russell's devel-stable
branch.

Russell: I put it on top of my for-next branch (

	git://git.pengutronix.de/git/ukl/linux.git for-next

) that you merged into your devel-stable some time ago. So assuming
you're fine with the patch, you can just repull or I can put it into
your patch tracker if you prefer it. In the latter case please tell me.

Best regards
Uwe

 arch/arm/kernel/entry-v7m.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index e00621f..52b2643 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -49,7 +49,7 @@ __irq_entry:
 	mov	r1, sp
 	stmdb	sp!, {lr}
 	@ routine called with r0 = irq number, r1 = struct pt_regs *
-	bl	nvic_do_IRQ
+	bl	nvic_handle_irq
 
 	pop	{lr}
 	@
-- 
1.8.3.1
