From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Mar 2011 15:12:49 +0000
Subject: [RFC PATCHv2 06/20] ARM: ux500: remove stubbed twd_timer_setup call
In-Reply-To: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
References: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1300201983-26124-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-ux500/localtimer.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/localtimer.c b/arch/arm/mach-ux500/localtimer.c
index 5ba1133..c648725 100644
--- a/arch/arm/mach-ux500/localtimer.c
+++ b/arch/arm/mach-ux500/localtimer.c
@@ -11,11 +11,9 @@
  * published by the Free Software Foundation.
  */
 #include <linux/init.h>
-#include <linux/smp.h>
 #include <linux/clockchips.h>
 
 #include <asm/irq.h>
-#include <asm/smp_twd.h>
 #include <asm/localtimer.h>
 
 /*
@@ -24,6 +22,5 @@
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	evt->irq = IRQ_LOCALTIMER;
-	twd_timer_setup(evt);
 	return 0;
 }
-- 
1.7.0.4
