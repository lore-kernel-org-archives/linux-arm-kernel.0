From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:21:06 +0000
Subject: [PATCH 18/24] ARM: iop: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDxK-0008DS-1R@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-iop/time.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 558cdfa..432a5b7 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -172,7 +172,5 @@ void __init iop_init_time(unsigned long tick_rate)
 	write_trr1(0xffffffff);
 	write_tcr1(0xffffffff);
 	write_tmr1(timer_ctl);
-	clocksource_calc_mult_shift(&iop_clocksource, tick_rate,
-				    IOP_MIN_RANGE);
-	clocksource_register(&iop_clocksource);
+	clocksource_register_hz(&iop_clocksource, tick_rate);
 }
-- 
1.6.2.5
