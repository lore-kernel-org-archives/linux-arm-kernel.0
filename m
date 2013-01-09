From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Jan 2013 15:30:05 +0900
Subject: [PATCH 6/8] ARM: shmobile: r8a7740: Use DT initialisation of INTC
In-Reply-To: <1357713007-4005-1-git-send-email-horms+renesas@verge.net.au>
References: <1357713007-4005-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1357713007-4005-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 28a2ab3..9fe7ca8 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -879,7 +879,7 @@ static const char *r8a7740_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.map_io		= r8a7740_map_io,
 	.init_early	= r8a7740_add_early_devices_dt,
-	.init_irq	= r8a7740_init_irq,
+	.init_irq	= r8a7740_init_irq_of,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= r8a7740_add_standard_devices_dt,
 	.timer		= &shmobile_timer,
-- 
1.7.10.4
