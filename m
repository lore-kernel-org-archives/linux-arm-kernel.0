From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 7 Sep 2011 10:30:33 +0200
Subject: [PATCH 1/4] mach-integrator: retire some timer macros
Message-ID: <1315384233-27332-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

These macros are not used by anything since the switch to
generic time in commit b9cedda230793cbf58eb012ddadedd490cc8e129
so let's retire them.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/integrator_ap.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 8cdc730..7748be1 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -322,18 +322,6 @@ static void __init ap_init(void)
 #define TIMER1_VA_BASE IO_ADDRESS(INTEGRATOR_TIMER1_BASE)
 #define TIMER2_VA_BASE IO_ADDRESS(INTEGRATOR_TIMER2_BASE)
 
-/*
- * How long is the timer interval?
- */
-#define TIMER_INTERVAL	(TICKS_PER_uSEC * mSEC_10)
-#if TIMER_INTERVAL >= 0x100000
-#define TICKS2USECS(x)	(256 * (x) / TICKS_PER_uSEC)
-#elif TIMER_INTERVAL >= 0x10000
-#define TICKS2USECS(x)	(16 * (x) / TICKS_PER_uSEC)
-#else
-#define TICKS2USECS(x)	((x) / TICKS_PER_uSEC)
-#endif
-
 static unsigned long timer_reload;
 
 static void integrator_clocksource_init(u32 khz)
-- 
1.7.3.2
