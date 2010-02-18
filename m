From: tony@atomide.com (Tony Lindgren)
Date: Wed, 17 Feb 2010 17:32:36 -0800
Subject: [PATCH 18/23] AM3517: Enable basic I2C Support
In-Reply-To: <20100218013012.32075.43788.stgit@baageli.muru.com>
References: <20100218013012.32075.43788.stgit@baageli.muru.com>
Message-ID: <20100218013235.32075.79075.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vaibhav Hiremath <hvaibhav@ti.com>

Add basic I2C board Hook-up support, where all the 3 I2C instances
are getting registered.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index ad323b4..af99faf 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -38,6 +38,15 @@
 #define LCD_PANEL_BKLIGHT_PWR	182
 #define LCD_PANEL_PWM		181
 
+static int __init am3517_evm_i2c_init(void)
+{
+	omap_register_i2c_bus(1, 400, NULL, 0);
+	omap_register_i2c_bus(2, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, 0);
+
+	return 0;
+}
+
 static int lcd_enabled;
 static int dvi_enabled;
 
@@ -216,6 +225,8 @@ static struct omap_board_mux board_mux[] __initdata = {
 
 static void __init am3517_evm_init(void)
 {
+	am3517_evm_i2c_init();
+
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	platform_add_devices(am3517_evm_devices,
 				ARRAY_SIZE(am3517_evm_devices));
