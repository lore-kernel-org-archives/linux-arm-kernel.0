From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:20:25 +0000
Subject: [PATCH 16/24] ARM: U300: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDwf-0008DK-GC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-u300/timer.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 3fc4472..377ff7f 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -412,9 +412,7 @@ static void __init u300_timer_init(void)
 	writel(U300_TIMER_APP_EGPT2_TIMER_ENABLE,
 		U300_TIMER_APP_VBASE + U300_TIMER_APP_EGPT2);
 
-	clocksource_calc_mult_shift(&clocksource_u300_1mhz,
-				    rate, APPTIMER_MIN_RANGE);
-	if (clocksource_register(&clocksource_u300_1mhz))
+	if (clocksource_register_hz(&clocksource_u300_1mhz, rate))
 		printk(KERN_ERR "timer: failed to initialize clock "
 		       "source %s\n", clocksource_u300_1mhz.name);
 
-- 
1.6.2.5
