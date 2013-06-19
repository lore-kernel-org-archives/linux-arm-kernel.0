From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 19 Jun 2013 22:22:20 +0900
Subject: [PATCH 2/5] ARM: shmobile: bockw: add I2C device support
In-Reply-To: <1371648143-18376-1-git-send-email-horms+renesas@verge.net.au>
References: <1371648143-18376-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371648143-18376-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch enables rx8581 on I2C0

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index bfe8f67..a4251cc 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -77,6 +77,13 @@ static struct sh_eth_plat_data ether_platform_data __initdata = {
 	.no_ether_link	= 1,
 };
 
+/* I2C */
+static struct i2c_board_info i2c0_devices[] = {
+	{
+		I2C_BOARD_INFO("rx8581", 0x51),
+	},
+};
+
 static const struct pinctrl_map bockw_pinctrl_map[] = {
 	/* Ether */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7778",
@@ -103,7 +110,10 @@ static void __init bockw_init(void)
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
 	r8a7778_add_ether_device(&ether_platform_data);
+	r8a7778_add_i2c_device(0);
 
+	i2c_register_board_info(0, i2c0_devices,
+				ARRAY_SIZE(i2c0_devices));
 	pinctrl_register_mappings(bockw_pinctrl_map,
 				  ARRAY_SIZE(bockw_pinctrl_map));
 	r8a7778_pinmux_init();
-- 
1.8.2.1
