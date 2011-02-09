From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  9 Feb 2011 21:40:09 +0100
Subject: [PATCH 3/4] ARM: omap: move omap_board_config_kernel to .init.data
In-Reply-To: <20110209192727.GC20795@atomide.com>
References: <20110209192727.GC20795@atomide.com>
Message-ID: <1297284010-2286-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This variable is only assigned in __init functions and never used later.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-omap/common.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 30c698e..d9f10a3 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -24,10 +24,11 @@
 
 #define NO_LENGTH_CHECK 0xffffffff
 
-struct omap_board_config_kernel *omap_board_config;
+struct omap_board_config_kernel *omap_board_config __initdata;
 int omap_board_config_size;
 
-static const void *get_config(u16 tag, size_t len, int skip, size_t *len_out)
+static const void *__init get_config(u16 tag, size_t len,
+		int skip, size_t *len_out)
 {
 	struct omap_board_config_kernel *kinfo = NULL;
 	int i;
-- 
1.7.2.3
