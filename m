From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Aug 2010 16:08:41 +0200
Subject: [PATCH 07/19] wip: ARM: omap: move omap_board_config_kernel to
	.init.data
In-Reply-To: <20100805140813.GA13859@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
Message-ID: <1281017333-5563-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Probably this works ...
---
 arch/arm/plat-omap/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 9cd4d91..b985cdc 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -46,7 +46,7 @@
 
 #define NO_LENGTH_CHECK 0xffffffff
 
-struct omap_board_config_kernel *omap_board_config;
+struct omap_board_config_kernel *omap_board_config __initdata;
 int omap_board_config_size;
 
 static const void *get_config(u16 tag, size_t len, int skip, size_t *len_out)
-- 
1.7.1
