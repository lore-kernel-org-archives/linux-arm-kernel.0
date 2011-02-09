From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  9 Feb 2011 21:40:10 +0100
Subject: [PATCH 4/4] wip: fix section mismatches in omap1_defconfig
In-Reply-To: <20110209192727.GC20795@atomide.com>
References: <20110209192727.GC20795@atomide.com>
Message-ID: <1297284010-2286-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

after these changes omap1_defconfig and omap2plus_defconfig don't have any
section mismatches any more, making it plausible that the patches earlier
in this series are OK.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-omap1/board-ams-delta.c |    4 ++--
 arch/arm/mach-omap1/board-fsample.c   |    2 +-
 drivers/usb/otg/isp1301_omap.c        |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 22cc8c8..560e33f 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -175,7 +175,7 @@ static struct omap_usb_config ams_delta_usb_config __initdata = {
 	.pins[0]	= 2,
 };
 
-static struct omap_board_config_kernel ams_delta_config[] = {
+static struct omap_board_config_kernel ams_delta_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
 };
 
@@ -259,7 +259,7 @@ static int ams_delta_camera_power(struct device *dev, int power)
 #define ams_delta_camera_power	NULL
 #endif
 
-static struct soc_camera_link __initdata ams_delta_iclink = {
+static struct soc_camera_link ams_delta_iclink = {
 	.bus_id         = 0,	/* OMAP1 SoC camera bus */
 	.i2c_adapter_id = 1,
 	.board_info     = &ams_delta_camera_board_info[0],
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 0efb9db..6b98eef 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -291,7 +291,7 @@ static struct omap_lcd_config fsample_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_board_config_kernel fsample_config[] = {
+static struct omap_board_config_kernel fsample_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&fsample_lcd_config },
 };
 
diff --git a/drivers/usb/otg/isp1301_omap.c b/drivers/usb/otg/isp1301_omap.c
index e00fa1b..8c6fdef 100644
--- a/drivers/usb/otg/isp1301_omap.c
+++ b/drivers/usb/otg/isp1301_omap.c
@@ -1510,7 +1510,7 @@ isp1301_start_hnp(struct otg_transceiver *dev)
 
 /*-------------------------------------------------------------------------*/
 
-static int __init
+static int __devinit
 isp1301_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 {
 	int			status;
-- 
1.7.2.3
