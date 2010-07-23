From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 23 Jul 2010 21:58:28 +0200
Subject: [PATCH 05/11] ARM: omap1: nokia770: move mipid_dev_init() to
	.init.text
In-Reply-To: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1279915120-4373-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mipid_dev_init() is only called by omap_nokia770_init that lives in
.init.text.  So it's save to move the former to .init.text, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-omap1/board-nokia770.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 71e1a3f..6c4dd0e 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -113,7 +113,7 @@ static struct mipid_platform_data nokia770_mipid_platform_data = {
 	.shutdown = mipid_shutdown,
 };
 
-static void mipid_dev_init(void)
+static void __init mipid_dev_init(void)
 {
 	const struct omap_lcd_config *conf;
 
-- 
1.7.1
