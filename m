From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 18 Sep 2015 13:41:21 +0800
Subject: [PATCH] ARM: OMAP2+: PM: Denote the cpuidle tracepoints as _rcuidle()
Message-ID: <1442554881-706-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpuidle tracepoints are called within a rcu_idle_exit() section, and
must be denoted with the _rcuidle() version of the tracepoint.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/mach-omap2/pm34xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 87b98bf9..2dbd378 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -301,11 +301,11 @@ static void omap3_pm_idle(void)
 	if (omap_irq_pending())
 		return;
 
-	trace_cpu_idle(1, smp_processor_id());
+	trace_cpu_idle_rcuidle(1, smp_processor_id());
 
 	omap_sram_idle();
 
-	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
+	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 }
 
 #ifdef CONFIG_SUSPEND
-- 
2.5.1
