From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 May 2012 08:38:21 +0100
Subject: [RFC PATCH 2/2] ARM: irq: remove unused irq_finish hook from core
 interrupt handling
In-Reply-To: <1338449901-10288-1-git-send-email-will.deacon@arm.com>
References: <1338449901-10288-1-git-send-email-will.deacon@arm.com>
Message-ID: <1338449901-10288-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq_finish hook is no longer used by any platforms, so remove it.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/irq.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 8349d4e..16cedb4 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -40,13 +40,6 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
-/*
- * No architecture-specific irq_finish function defined in arm/arch/irqs.h.
- */
-#ifndef irq_finish
-#define irq_finish(irq) do { } while (0)
-#endif
-
 unsigned long irq_err_count;
 
 int arch_show_interrupts(struct seq_file *p, int prec)
@@ -85,9 +78,6 @@ void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 		generic_handle_irq(irq);
 	}
 
-	/* AT91 specific workaround */
-	irq_finish(irq);
-
 	irq_exit();
 	set_irq_regs(old_regs);
 }
-- 
1.7.3.4
