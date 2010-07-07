From: tony@atomide.com (Tony Lindgren)
Date: Wed, 07 Jul 2010 12:44:20 +0300
Subject: [PATCH 06/13] omap: rx51: Add platform_data for tlv320aic3x with
	reset gpionumber
In-Reply-To: <20100707094308.2562.91921.stgit@baageli.muru.com>
References: <20100707094308.2562.91921.stgit@baageli.muru.com>
Message-ID: <20100707094420.2562.76871.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jarkko Nikula <jhnikula@gmail.com>

Proper operation of the tlv320aic3x audio codec requires that reset
sequencing is done in pair with supply voltages when using the regulator
framework. Add the codec reset gpio used in Nokia RX51 to tlv320aic3x
data.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 3d95534..e350f0b 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -32,6 +32,8 @@
 #include <plat/onenand.h>
 #include <plat/gpmc-smc91x.h>
 
+#include <sound/tlv320aic3x.h>
+
 #include "mux.h"
 #include "hsmmc.h"
 
@@ -707,6 +709,10 @@ static struct twl4030_platform_data rx51_twldata __initdata = {
 	.vio			= &rx51_vio,
 };
 
+static struct aic3x_pdata rx51_aic3x_data __initdata = {
+	.gpio_reset		= 60,
+};
+
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 	{
 		I2C_BOARD_INFO("twl5030", 0x48),
@@ -719,6 +725,7 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
+		.platform_data = &rx51_aic3x_data,
 	},
 };
 
