From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue,  2 Sep 2014 14:19:14 -0700
Subject: [PATCH v2 9/9] ARM: zynq: Rename 'zynq_platform_cpu_die'
In-Reply-To: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1409692754-13437-10-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Match the naming pattern of all other SMP ops and rename
zynq_platform_cpu_die --> zynq_cpu_die.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
v2:
 - make comments comply to kernel-doc format
---
 arch/arm/mach-zynq/platsmp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index f722b5a83a45..52d768ff7857 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -137,12 +137,14 @@ static int zynq_cpu_kill(unsigned cpu)
 	return 1;
 }
 
-/*
- * platform-specific code to shutdown a CPU
+/**
+ * zynq_cpu_die - Let a CPU core die
+ * @cpu:	Dying CPU
  *
- * Called with IRQs disabled
+ * Platform-specific code to shutdown a CPU.
+ * Called with IRQs disabled on the dying CPU.
  */
-static void zynq_platform_cpu_die(unsigned int cpu)
+static void zynq_cpu_die(unsigned int cpu)
 {
 	zynq_slcr_cpu_state_write(cpu, true);
 
@@ -162,7 +164,7 @@ struct smp_operations zynq_smp_ops __initdata = {
 	.smp_boot_secondary	= zynq_boot_secondary,
 	.smp_secondary_init	= zynq_secondary_init,
 #ifdef CONFIG_HOTPLUG_CPU
-	.cpu_die		= zynq_platform_cpu_die,
+	.cpu_die		= zynq_cpu_die,
 	.cpu_kill		= zynq_cpu_kill,
 #endif
 };
-- 
2.1.0.1.g27b9230
