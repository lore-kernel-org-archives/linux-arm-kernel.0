From: nobuhiro.iwamatsu.yj@renesas.com (Nobuhiro Iwamatsu)
Date: Thu, 22 Nov 2012 17:00:10 +0900
Subject: [PATCH v5 13/15] ARM: shmobile: sh7372: Use DT initialisation of INTC
In-Reply-To: <1353571213-26006-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
References: <1353571213-26006-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Message-ID: <1353571213-26006-14-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh7372.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index a07954f..bbe6e2a 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -1096,7 +1096,7 @@ DT_MACHINE_START(SH7372_DT, "Generic SH7372 (Flattened Device Tree)")
 	.map_io		= sh7372_map_io,
 	.init_early	= sh7372_add_early_devices_dt,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= sh7372_init_irq,
+	.init_irq	= sh7372_init_irq_of,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= sh7372_add_standard_devices_dt,
 	.timer		= &shmobile_timer,
-- 
1.7.10.4
