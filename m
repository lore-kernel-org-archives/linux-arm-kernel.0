From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Feb 2012 16:34:25 -0800
Subject: [PATCH] ARM: OMAP1: Fix out-of-bounds array access for Innovator
Message-ID: <20120222003425.GU18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we can get the following on some compilers:

arch/arm/mach-omap1/board-innovator.c:419:19: warning:
array subscript is above array bounds [-Warray-bounds]
arch/arm/mach-omap1/board-innovator.c:425:19: warning:
array subscript is above array bounds [-Warray-bounds]

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -416,13 +416,13 @@ static void __init innovator_init(void)
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap1510()) {
 		omap1_usb_init(&innovator1510_usb_config);
-		innovator_config[1].data = &innovator1510_lcd_config;
+		innovator_config[0].data = &innovator1510_lcd_config;
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP16XX
 	if (cpu_is_omap1610()) {
 		omap1_usb_init(&h2_usb_config);
-		innovator_config[1].data = &innovator1610_lcd_config;
+		innovator_config[0].data = &innovator1610_lcd_config;
 	}
 #endif
 	omap_board_config = innovator_config;
