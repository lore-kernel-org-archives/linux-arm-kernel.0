From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:17 +0100
Subject: [PATCH 22/39] arm/imx: remove #ifndef CONFIG_COMMON_CLKDEV block
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-22-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

COMMON_CLKDEV is used on all imx platforms, so this isn't used.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/clock.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/clock.h b/arch/arm/plat-mxc/include/mach/clock.h
index 43a82d0..753a598 100644
--- a/arch/arm/plat-mxc/include/mach/clock.h
+++ b/arch/arm/plat-mxc/include/mach/clock.h
@@ -26,13 +26,6 @@
 struct module;
 
 struct clk {
-#ifndef CONFIG_COMMON_CLKDEV
-	/* As soon as i.MX1 and i.MX31 switched to clkdev, this
-	 * block can go away */
-	struct list_head node;
-	struct module *owner;
-	const char *name;
-#endif
 	int id;
 	/* Source clock this clk depends on */
 	struct clk *parent;
-- 
1.6.6.2
