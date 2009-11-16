From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Nov 2009 15:28:43 -0800
Subject: [PATCH 11/12] omap3: zoom: Drop i2c-1 speed to 2400
In-Reply-To: <20091116232435.24892.81547.stgit@localhost>
References: <20091116232435.24892.81547.stgit@localhost>
Message-ID: <20091116232843.24892.13596.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: vikram pandita <vikram.pandita@ti.com>

The I2C-1 bus frequency on zoom2/zoom3/sdp3630 should be 2.4 MHz.
The speed is limited by TWL5030/GAIA; a higher speed could lead to errors
on the interface.

The maximum I2C speed depends on the system clock for GAIA:
2.2 MHz (sys-clk = 19.2 MHz)
2.4 MHz (sys-clk = 26 MHz)
2.9 MHz (sys-clk = 38.4 MHz)

For Zoom2/Zoom3/SDP3630 the system clock is 26Mhz
and hence choose 2.4Mhz for I2C1 bus speed

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/board-zoom-peripherals.c

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
old mode 100644
new mode 100755
index 3535b7a..f14baa3
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -243,7 +243,7 @@ static struct twl4030_platform_data zoom_twldata = {
 
 static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
 	{
-		I2C_BOARD_INFO("twl4030", 0x48),
+		I2C_BOARD_INFO("twl5030", 0x48),
 		.flags		= I2C_CLIENT_WAKE,
 		.irq		= INT_34XX_SYS_NIRQ,
 		.platform_data	= &zoom_twldata,
@@ -252,7 +252,7 @@ static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
 
 static int __init omap_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, zoom_i2c_boardinfo,
+	omap_register_i2c_bus(1, 2400, zoom_i2c_boardinfo,
 			ARRAY_SIZE(zoom_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
