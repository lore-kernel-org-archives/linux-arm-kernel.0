From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Aug 2010 16:08:42 +0200
Subject: [PATCH 08/19] ARM: omap: ams-delta: move config to .init.data
In-Reply-To: <20100805140813.GA13859@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
Message-ID: <1281017333-5563-8-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most other boards have their config in .init.data, too, so this should
be OK.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-omap1/board-ams-delta.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 0a9d61d..71353f9 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -173,7 +173,7 @@ static struct omap_usb_config ams_delta_usb_config __initdata = {
 	.pins[0]	= 2,
 };
 
-static struct omap_board_config_kernel ams_delta_config[] = {
+static struct omap_board_config_kernel ams_delta_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
 };
 
-- 
1.7.1
