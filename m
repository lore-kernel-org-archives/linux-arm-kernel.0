From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:32:24 +0100
Subject: [PATCH 73/97] ARM: l2c: zynq: convert to generic l2c initialisation
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerHs-0001Ye-Vo@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-zynq/common.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 1e617a6dedc3..d1e992e6403e 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -67,11 +67,6 @@ static void __init zynq_init_machine(void)
 {
 	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
 
-	/*
-	 * 64KB way size, 8-way associativity, parity disabled
-	 */
-	l2x0_of_init(0x02000000, 0xf0ffffff);
-
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	platform_device_register(&zynq_cpuidle_device);
@@ -133,6 +128,9 @@ static const char * const zynq_dt_match[] = {
 };
 
 DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
+	/* 64KB way size, 8-way associativity, parity disabled */
+	.l2c_aux_val	= 0x02000000,
+	.l2c_aux_mask	= 0xf0ffffff,
 	.smp		= smp_ops(zynq_smp_ops),
 	.map_io		= zynq_map_io,
 	.init_irq	= zynq_irq_init,
-- 
1.8.3.1
