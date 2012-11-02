From: vaibhav.bedia@ti.com (Vaibhav Bedia)
Date: Fri, 2 Nov 2012 18:02:42 +0530
Subject: [PATCH 11/15] ARM: OMAP: timer: Interchange clksrc and clkevt for
 AM33XX
In-Reply-To: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM33XX has only one usable timer in the WKUP domain.
Currently the timer instance in WKUP domain is used
as the clockevent and the timer in non-WKUP domain
as the clocksource. The timer in WKUP domain can keep
running in suspend from a 32K clock and hence serve
as the persistent clock. To enable this, interchange
the timers used as clocksource and clockevent for
AM33XX. A subsequent patch will add suspend-resume
support for the clockevent to ensure that there are
no issues with timekeeping.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 565e575..6584ee0 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -460,7 +460,7 @@ OMAP_SYS_TIMER(3_secure)
 #endif
 
 #ifdef CONFIG_SOC_AM33XX
-OMAP_SYS_TIMER_INIT(3_am33xx, 1, OMAP4_MPU_SOURCE, 2, OMAP4_MPU_SOURCE)
+OMAP_SYS_TIMER_INIT(3_am33xx, 2, OMAP4_MPU_SOURCE, 1, OMAP4_MPU_SOURCE)
 OMAP_SYS_TIMER(3_am33xx)
 #endif
 
-- 
1.7.0.4
