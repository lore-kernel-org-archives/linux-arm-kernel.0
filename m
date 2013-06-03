From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Jun 2013 00:05:07 +0200
Subject: [PATCH] clk: spear: fix build error for spear3xx
Message-ID: <2592841.P0ZcyhdZJA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is required to be able to disable spear320 support
after the spear320_clk_init() prototype changed for the real
function but not for the dummy.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/clk/spear/spear3xx_clock.c b/drivers/clk/spear/spear3xx_clock.c
index f9ec43f..080c3c5 100644
--- a/drivers/clk/spear/spear3xx_clock.c
+++ b/drivers/clk/spear/spear3xx_clock.c
@@ -369,7 +369,7 @@ static void __init spear320_clk_init(void __iomem *soc_config_base)
 	clk_register_clkdev(clk, NULL, "60100000.serial");
 }
 #else
-static inline void spear320_clk_init(void) { }
+static inline void spear320_clk_init(void __iomem *soc_config_base) { }
 #endif
 
 void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_base)
