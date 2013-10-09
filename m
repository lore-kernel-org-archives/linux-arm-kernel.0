From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  9 Oct 2013 13:28:07 -0300
Subject: [PATCH] ARM: mach-imx: clk-imx51-imx53: Remove return value from
 mx53_clocks_init()
Message-ID: <1381336087-19821-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 4d9d18a56 (ARM: imx: remove custom .init_time hook), 
mx53_clocks_init() does not return an integer anymore, so adjust it in order to
fix the following build warning:

arch/arm/mach-imx/clk-imx51-imx53.c:579:2: warning: 'return' with a value, in function returning void [enabled by default]

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-imx51-imx53.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index fa4de9a..ce37af2 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -575,7 +575,5 @@ static void __init mx53_clocks_init(struct device_node *np)
 	WARN_ON(!base);
 	irq = irq_of_parse_and_map(np, 0);
 	mxc_timer_init(base, irq);
-
-	return 0;
 }
 CLK_OF_DECLARE(imx53_ccm, "fsl,imx53-ccm", mx53_clocks_init);
-- 
1.8.1.2
