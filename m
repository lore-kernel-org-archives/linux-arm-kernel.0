From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 28 May 2013 13:58:05 +0530
Subject: [PATCH v2 4/5] ARM: davinci: da8xx: remove da8xx_uart_clk_enable
In-Reply-To: <1369729686-6595-1-git-send-email-prakash.pm@ti.com>
References: <1369729686-6595-1-git-send-email-prakash.pm@ti.com>
Message-ID: <1369729686-6595-5-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Serial clocks are enabled from of_platform_serial_setup:of_serial.c,
so remove davinci_serial_setup_clk from here.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/mach-davinci/da8xx-dt.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index e429945..9683cbd 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -20,13 +20,6 @@
 
 #define DA8XX_NUM_UARTS	3
 
-static void __init da8xx_uart_clk_enable(void)
-{
-	int i;
-	for (i = 0; i < DA8XX_NUM_UARTS; i++)
-		davinci_serial_setup_clk(i, NULL);
-}
-
 static struct of_device_id da8xx_irq_match[] __initdata = {
 	{ .compatible = "ti,cp-intc", .data = cp_intc_of_init, },
 	{ }
@@ -60,7 +53,6 @@ static void __init da850_init_machine(void)
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     da850_auxdata_lookup, NULL);
 
-	da8xx_uart_clk_enable();
 }
 
 static const char *da850_boards_compat[] __initdata = {
-- 
1.7.4.1
