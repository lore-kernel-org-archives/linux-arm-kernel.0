From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Apr 2010 16:12:05 -0700
Subject: [PATCH 26/28] omap: Devkit8000: Change position of init calls
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Message-ID: <20100423231205.31953.89142.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Weber <weber@corscience.de>

Change position of calling serial and ethernet initialization.

Signed-off-by: Thomas Weber <weber@corscience.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index d605e05..0b4abd4 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -649,6 +649,10 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 static void __init devkit8000_init(void)
 {
+	omap_serial_init();
+
+	omap_dm9000_init();
+
 	devkit8000_i2c_init();
 	platform_add_devices(devkit8000_devices,
 			ARRAY_SIZE(devkit8000_devices));
@@ -658,10 +662,6 @@ static void __init devkit8000_init(void)
 	spi_register_board_info(devkit8000_spi_board_info,
 	ARRAY_SIZE(devkit8000_spi_board_info));
 
-	omap_serial_init();
-
-	omap_dm9000_init();
-
 	devkit8000_ads7846_init();
 
 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
