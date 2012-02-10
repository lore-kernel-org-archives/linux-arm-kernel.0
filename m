From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Fri, 10 Feb 2012 17:40:16 +0100
Subject: [PATCH] ARM: OMAP1: ams-delta: fix incorrect section tags
In-Reply-To: <Message-ID: <1580046.EEGIFOPvyy@vclass>
References: <Message-ID: <1580046.EEGIFOPvyy@vclass>
Message-ID: <1328892016-20673-1-git-send-email-jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While resolving section mismatches introduced with recent patches
to for-next, a few dangerous, driver bind/unbind unaware section
tagging already present in mainline have been identified. Fix them.

Created and tested against linux-3.3-rc2.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/mach-omap1/board-ams-delta.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 88909cc..41589ed 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -163,7 +163,7 @@ static struct omap_lcd_config ams_delta_lcd_config = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_usb_config ams_delta_usb_config __initdata = {
+static struct omap_usb_config ams_delta_usb_config = {
 	.register_host	= 1,
 	.hmc_mode	= 16,
 	.pins[0]	= 2,
@@ -202,7 +202,7 @@ static const struct matrix_keymap_data ams_delta_keymap_data = {
 	.keymap_size	= ARRAY_SIZE(ams_delta_keymap),
 };
 
-static struct omap_kp_platform_data ams_delta_kp_data __initdata = {
+static struct omap_kp_platform_data ams_delta_kp_data = {
 	.rows		= 8,
 	.cols		= 8,
 	.keymap_data	= &ams_delta_keymap_data,
-- 
1.7.3.4
