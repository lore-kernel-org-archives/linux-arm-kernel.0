From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri,  5 Sep 2014 16:33:14 +0100
Subject: [PATCH v2 1/5] ARM: remove unused do_unexp_fiq() function
In-Reply-To: <1409931198-22600-1-git-send-email-daniel.thompson@linaro.org>
References: <1409846620-14542-1-git-send-email-daniel.thompson@linaro.org>
 <1409931198-22600-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1409931198-22600-2-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

do_unexp_fiq() has never been called by any code in the last 10 years,
it's about time it was removed!

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/traps.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index c8e4bb7..a447dcc 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -460,12 +460,6 @@ die_sig:
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
1.9.3
