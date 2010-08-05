From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Aug 2010 16:08:38 +0200
Subject: [PATCH 04/19] ARM: omap1: nokia770: move mipid_dev_init() to
	.init.text
In-Reply-To: <20100805140813.GA13859@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
Message-ID: <1281017333-5563-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mipid_dev_init() is only called by omap_nokia770_init that lives in
.init.text.  So it's save to move the former to .init.text, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-omap1/board-nokia770.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 8c28b10..37d78da 100644
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
