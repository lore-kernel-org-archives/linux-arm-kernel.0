From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 28 Mar 2013 17:38:12 +0100
Subject: [PATCH v3 12/12] arm: zynq: Get rid of xilinx function prefix
In-Reply-To: <1364488692-18709-1-git-send-email-michal.simek@xilinx.com>
References: <1364488692-18709-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <1d85f4bc80481dc5bbef1910b08373566a2fa576.1364488495.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xilinx is vendor name not SoC name. Use zynq instead.

Also remove one checkpatch warning:
WARNING: static const char * array should probably be
static const char * const
+static const char *xilinx_dt_match[] = {

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
v3: First version - based on discussion on mailing list
---
 arch/arm/mach-zynq/common.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 8981345..5bfe703 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -46,10 +46,10 @@ static struct of_device_id zynq_of_bus_ids[] __initdata = {
 };
 
 /**
- * xilinx_init_machine() - System specific initialization, intended to be
- *			   called from board specific initialization.
+ * zynq_init_machine - System specific initialization, intended to be
+ *		       called from board specific initialization.
  */
-static void __init xilinx_init_machine(void)
+static void __init zynq_init_machine(void)
 {
 	/*
 	 * 64KB way size, 8-way associativity, parity disabled
@@ -59,7 +59,7 @@ static void __init xilinx_init_machine(void)
 	of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);
 }
 
-static void __init xilinx_zynq_timer_init(void)
+static void __init zynq_timer_init(void)
 {
 	zynq_slcr_init();
 	clocksource_of_init();
@@ -84,9 +84,9 @@ static void __init zynq_scu_map_io(void)
 }
 
 /**
- * xilinx_map_io() - Create memory mappings needed for early I/O.
+ * zynq_map_io - Create memory mappings needed for early I/O.
  */
-static void __init xilinx_map_io(void)
+static void __init zynq_map_io(void)
 {
 	debug_ll_io_init();
 	zynq_scu_map_io();
@@ -97,7 +97,7 @@ static void zynq_system_reset(char mode, const char *cmd)
 	zynq_slcr_system_reset();
 }
 
-static const char *xilinx_dt_match[] = {
+static const char * const zynq_dt_match[] = {
 	"xlnx,zynq-zc702",
 	"xlnx,zynq-7000",
 	NULL
@@ -105,10 +105,10 @@ static const char *xilinx_dt_match[] = {
 
 MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
 	.smp		= smp_ops(zynq_smp_ops),
-	.map_io		= xilinx_map_io,
+	.map_io		= zynq_map_io,
 	.init_irq	= irqchip_init,
-	.init_machine	= xilinx_init_machine,
-	.init_time	= xilinx_zynq_timer_init,
-	.dt_compat	= xilinx_dt_match,
+	.init_machine	= zynq_init_machine,
+	.init_time	= zynq_timer_init,
+	.dt_compat	= zynq_dt_match,
 	.restart	= zynq_system_reset,
 MACHINE_END
-- 
1.7.9.7
