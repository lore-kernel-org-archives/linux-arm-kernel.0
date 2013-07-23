From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 23 Jul 2013 12:32:44 +0100
Subject: [PATCH 5/5] ARM: zynq: remove unnecessary setting of cpu_present_mask
In-Reply-To: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1374579164-30255-6-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

This patch also removes setting cpu_present_mask as platforms should
only re-initialize it in smp_prepare_cpus() if present != possible.

Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/arm/mach-zynq/platsmp.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index 689fbbc..ae121b8 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -114,15 +114,6 @@ static void __init zynq_smp_init_cpus(void)
 
 static void __init zynq_smp_prepare_cpus(unsigned int max_cpus)
 {
-	int i;
-
-	/*
-	 * Initialise the present map, which describes the set of CPUs
-	 * actually populated at the present time.
-	 */
-	for (i = 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
-
 	scu_enable(zynq_scu_base);
 }
 
-- 
1.8.1.2
