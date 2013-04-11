From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Apr 2013 17:18:46 +0900
Subject: [PATCH] ARM: shmobile: use r8a7790 timer setup code on Lager
In-Reply-To: <1365668326-22518-1-git-send-email-horms+renesas@verge.net.au>
References: <1365668326-22518-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1365668326-22518-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use the r8a7790 timer init function on Lager
to make sure the architected timer is started
regardless of boot loader setting.

Signed-off-by: Magnus Damm <damm@opensource.se>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index ea6f9e5..f587187 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -40,7 +40,7 @@ static const char *lager_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(LAGER_DT, "lager")
 	.init_irq	= irqchip_init,
-	.init_time	= shmobile_timer_init,
+	.init_time	= r8a7790_timer_init,
 	.init_machine	= lager_add_standard_devices,
 	.dt_compat	= lager_boards_compat_dt,
 MACHINE_END
-- 
1.7.10.4
