From: markus.mayer@linaro.org (Markus Mayer)
Date: Tue, 25 Feb 2014 14:17:46 -0800
Subject: [PATCH 4/4] ARM: bcm281xx: Rename board_init() function
In-Reply-To: <1393366666-28625-1-git-send-email-markus.mayer@linaro.org>
References: <1393366666-28625-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <1393366666-28625-5-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename board_init() to bcm281xx_init(), so the name reflects the board
specific nature of this function.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
---
 arch/arm/mach-bcm/board_bcm281xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-bcm/board_bcm281xx.c b/arch/arm/mach-bcm/board_bcm281xx.c
index fe00ff3..8fee05b 100644
--- a/arch/arm/mach-bcm/board_bcm281xx.c
+++ b/arch/arm/mach-bcm/board_bcm281xx.c
@@ -56,7 +56,7 @@ static void bcm281xx_restart(enum reboot_mode mode, const char *cmd)
 	while (1);
 }
 
-static void __init board_init(void)
+static void __init bcm281xx_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL,
 		&platform_bus);
@@ -66,7 +66,7 @@ static void __init board_init(void)
 static const char * const bcm11351_dt_compat[] = { "brcm,bcm11351", NULL, };
 
 DT_MACHINE_START(BCM11351_DT, "BCM281xx Broadcom Application Processor")
-	.init_machine = board_init,
+	.init_machine = bcm281xx_init,
 	.restart = bcm281xx_restart,
 	.dt_compat = bcm11351_dt_compat,
 MACHINE_END
-- 
1.7.9.5
