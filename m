From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  8 Oct 2013 18:05:43 +0900
Subject: [PATCH 4/4] ARM: shmobile: lager: Constify platform data and resources
In-Reply-To: <cover.1381222967.git.horms+renesas@verge.net.au>
References: <cover.1381222967.git.horms+renesas@verge.net.au>
Message-ID: <27113d63daac0aacaa26b1fabfc23391de4284f4.1381222967.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Platform data and resources for Lager devices are kmemdup()ed when the
corresponding devices are registered and can thus be declared as const.
Do so.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 4047fac..afd5137 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -55,7 +55,7 @@ static struct gpio_led lager_leds[] = {
 	},
 };
 
-static __initdata struct gpio_led_platform_data lager_leds_pdata = {
+static const struct gpio_led_platform_data lager_leds_pdata __initconst = {
 	.leds		= lager_leds,
 	.num_leds	= ARRAY_SIZE(lager_leds),
 };
@@ -71,7 +71,7 @@ static struct gpio_keys_button gpio_buttons[] = {
 	GPIO_KEY(KEY_1,		RCAR_GP_PIN(1, 14),	"SW2-pin1"),
 };
 
-static __initdata struct gpio_keys_platform_data lager_keys_pdata = {
+static const struct gpio_keys_platform_data lager_keys_pdata __initconst = {
 	.buttons	= gpio_buttons,
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
 };
@@ -83,24 +83,24 @@ static struct regulator_consumer_supply fixed3v3_power_consumers[] =
 };
 
 /* MMCIF */
-static struct sh_mmcif_plat_data mmcif1_pdata __initdata = {
+static const struct sh_mmcif_plat_data mmcif1_pdata __initconst = {
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
 };
 
-static struct resource mmcif1_resources[] __initdata = {
+static const struct resource mmcif1_resources[] __initconst = {
 	DEFINE_RES_MEM_NAMED(0xee220000, 0x80, "MMCIF1"),
 	DEFINE_RES_IRQ(gic_spi(170)),
 };
 
 /* Ether */
-static struct sh_eth_plat_data ether_pdata __initdata = {
+static const struct sh_eth_plat_data ether_pdata __initconst = {
 	.phy			= 0x1,
 	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
 	.phy_interface		= PHY_INTERFACE_MODE_RMII,
 	.ether_link_active_low	= 1,
 };
 
-static struct resource ether_resources[] __initdata = {
+static const struct resource ether_resources[] __initconst = {
 	DEFINE_RES_MEM(0xee700000, 0x400),
 	DEFINE_RES_IRQ(gic_spi(162)),
 };
@@ -155,7 +155,7 @@ static void __init lager_add_standard_devices(void)
 					  &ether_pdata, sizeof(ether_pdata));
 }
 
-static const char *lager_boards_compat_dt[] __initdata = {
+static const char * const lager_boards_compat_dt[] __initconst = {
 	"renesas,lager",
 	NULL,
 };
-- 
1.8.4
