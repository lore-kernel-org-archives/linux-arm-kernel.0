From: thomas@tomweber.eu (Thomas Weber)
Date: Thu, 15 Nov 2012 19:12:03 +0100
Subject: [PATCH] ARM: OMAP3: Devkit8000: Add DDC i2c_bus_num
Message-ID: <1353003123-7335-1-git-send-email-thomas@tomweber.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i2c bus number for DVI output.
The driver uses this to detect if a panel is connected and to read EDID.

Signed-off-by: Thomas Weber <thomas@tomweber.eu>
---
 arch/arm/mach-omap2/board-devkit8000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 1fd161e..6f04f0f 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -139,6 +139,7 @@ static struct omap_dss_device devkit8000_lcd_device = {
 
 static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= -1,
+	.i2c_bus_num		= 1,
 };
 
 static struct omap_dss_device devkit8000_dvi_device = {
-- 
1.8.0
