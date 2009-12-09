From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Dec 2009 18:11:12 -0800
Subject: [PATCH] Fix compile on Innovator 1610 for smc91x
Message-ID: <mailman.78.1260324820.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix compile on Innovator 1610 for smc91x

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 91b3b8e..2133b00 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -143,6 +143,11 @@ static struct platform_device innovator_kp_device = {
 	.resource	= innovator_kp_resources,
 };
 
+static struct smc91x_platdata innovator_smc91x_info = {
+	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
+};
 
 #ifdef CONFIG_ARCH_OMAP15XX
 
@@ -160,12 +165,6 @@ static struct map_desc innovator1510_io_desc[] __initdata = {
 	}
 };
 
-static struct smc91x_platdata innovator_smc91x_info = {
-	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
-	.leda	= RPC_LED_100_10,
-	.ledb	= RPC_LED_TX_RX,
-};
-
 static struct resource innovator1510_smc91x_resources[] = {
 	[0] = {
 		.start	= OMAP1510_FPGA_ETHR_START,	/* Physical */

--ZJcv+A0YCCLh2VIg--
