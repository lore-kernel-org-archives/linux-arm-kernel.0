From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 14:00:31 +0100
Subject: [PATCH 11/13] ARM i.MX51 mx51 babbage: remove unnecessary
	CONFIG_KEYBOARD_IMX ifdefs
In-Reply-To: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
References: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296133233-1062-12-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/board-mx51_3ds.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index feb2800..58a2574 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -79,7 +79,6 @@ static inline void mxc_init_imx_uart(void)
 {
 }
 
-#if defined(CONFIG_KEYBOARD_IMX) || defined(CONFIG_KEYBOARD_IMX_MODULE)
 static int mx51_3ds_board_keymap[] = {
 	KEY(0, 0, KEY_1),
 	KEY(0, 1, KEY_2),
@@ -115,16 +114,6 @@ static const struct matrix_keymap_data mx51_3ds_map_data __initconst = {
 	.keymap_size	= ARRAY_SIZE(mx51_3ds_board_keymap),
 };
 
-static void mxc_init_keypad(void)
-{
-	imx51_add_imx_keypad(&mx51_3ds_map_data);
-}
-#else
-static inline void mxc_init_keypad(void)
-{
-}
-#endif
-
 static int mx51_3ds_spi2_cs[] = {
 	MXC_SPI_CS(0),
 	MX51_3DS_ECSPI2_CS,
@@ -166,7 +155,7 @@ static void __init mxc_board_init(void)
 				    "devices on the board are unusable.\n");
 
 	imx51_add_sdhci_esdhc_imx(0, NULL);
-	mxc_init_keypad();
+	imx51_add_imx_keypad(&mx51_3ds_map_data);
 	imx51_add_imx2_wdt(0, NULL);
 }
 
-- 
1.7.2.3
