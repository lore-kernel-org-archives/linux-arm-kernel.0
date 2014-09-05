From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 05 Sep 2014 10:41:33 +0100
Subject: [PATCH FYI 2/4] ARM: remove unused do_unexp_fiq() function
In-Reply-To: <20140905094056.GD30401@n2100.arm.linux.org.uk>
References: <20140905094056.GD30401@n2100.arm.linux.org.uk>
Message-ID: <E1XPq1N-0000RK-Cn@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

do_unexp_fiq() has never been called by any code in the last 10 years,
it's about time it was removed!

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/traps.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index c8e4bb714944..a447dcc4d2f7 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -460,12 +460,6 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	arm_notify_die("Oops - undefined instruction", regs, &info, 0, 6);
 }
 
-asmlinkage void do_unexp_fiq (struct pt_regs *regs)
-{
-	printk("Hmm.  Unexpected FIQ received, but trying to continue\n");
-	printk("You may have a hardware problem...\n");
-}
-
 /*
  * bad_mode handles the impossible case in the vectors.  If you see one of
  * these, then it's extremely serious, and could mean you have buggy hardware.
-- 
1.8.3.1
