From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 2 Aug 2011 00:43:15 +0200
Subject: [PATCH 2/3] ARM: mmp: Switch to using timer 1 as clocksource timer.
Message-ID: <20110801224315.GH912@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@laptop.org>
---
 arch/arm/mach-mmp/time.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index b0ce1a8..80d8870 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -51,12 +51,12 @@ static inline uint32_t timer_read(void)
 {
 	int delay = 100;
 
-	__raw_writel(1, TIMERS_VIRT_BASE + TMR_CVWR(0));
+	__raw_writel(1, TIMERS_VIRT_BASE + TMR_CVWR(1));
 
 	while (delay--)
 		cpu_relax();
 
-	return __raw_readl(TIMERS_VIRT_BASE + TMR_CVWR(0));
+	return __raw_readl(TIMERS_VIRT_BASE + TMR_CVWR(1));
 }
 
 unsigned long long notrace sched_clock(void)
-- 
1.7.6
