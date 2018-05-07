From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Mon, 7 May 2018 15:44:13 +0800
Subject: [PATCH] arm: berlin: remove non-necessary flush_cache_all()
Message-ID: <20180507154413.5ca0838a@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I believe the flush_cache_all() after scu_enable() is to "Ensure that
the data accessed by CPU0 before the SCU was initialised is visible
to the other CPUs." as commented in scu_enable(). So flush_cache_all()
here is a duplication of the one in scu_enable(), remove it.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/mach-berlin/platsmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
index 7586b7aec272..a8ae4a566d99 100644
--- a/arch/arm/mach-berlin/platsmp.c
+++ b/arch/arm/mach-berlin/platsmp.c
@@ -81,7 +81,6 @@ static void __init berlin_smp_prepare_cpus(unsigned int max_cpus)
 		goto unmap_scu;
 
 	scu_enable(scu_base);
-	flush_cache_all();
 
 	/*
 	 * Write the first instruction the CPU will execute after being reset
-- 
2.17.0
