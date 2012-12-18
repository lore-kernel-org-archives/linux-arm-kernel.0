From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 18 Dec 2012 09:46:13 +0900
Subject: [PATCH 9/9] ARM: shmobile: sh7372: Use DT initialisation of INTC
In-Reply-To: <1355791573-20281-1-git-send-email-horms+renesas@verge.net.au>
References: <1355791573-20281-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1355791573-20281-10-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh7372.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 90af2e9..0f36e45 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -1103,7 +1103,7 @@ DT_MACHINE_START(SH7372_DT, "Generic SH7372 (Flattened Device Tree)")
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
