From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 20 Aug 2014 13:41:55 -0700
Subject: [PATCH 9/9] ARM: zynq: Rename 'zynq_platform_cpu_die'
In-Reply-To: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1408567315-28479-10-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Match the naming pattern of all other SMP ops and rename
zynq_platform_cpu_die --> zynq_cpu_die.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/mach-zynq/platsmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index 04e578718aa2..95933c5e70e1 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -138,7 +138,7 @@ static int zynq_cpu_kill(unsigned cpu)
  *
  * Called with IRQs disabled
  */
-static void zynq_platform_cpu_die(unsigned int cpu)
+static void zynq_cpu_die(unsigned int cpu)
 {
 	zynq_slcr_cpu_state_write(cpu, true);
 
@@ -158,7 +158,7 @@ struct smp_operations zynq_smp_ops __initdata = {
 	.smp_boot_secondary	= zynq_boot_secondary,
 	.smp_secondary_init	= zynq_secondary_init,
 #ifdef CONFIG_HOTPLUG_CPU
-	.cpu_die		= zynq_platform_cpu_die,
+	.cpu_die		= zynq_cpu_die,
 	.cpu_kill		= zynq_cpu_kill,
 #endif
 };
-- 
2.0.1.1.gfbfc394
