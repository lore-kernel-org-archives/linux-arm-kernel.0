From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 17:16:12 +0200
Subject: [PATCH, RFC 08/22] OMAPDSS: DPI needs DSI
In-Reply-To: <1367507786-505303-1-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
Message-ID: <1367507786-505303-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dpi.c file cannot be build correctly when the dsi.c file is
disabled in Kconfig. This clarifies the dependency in Kconfig
to avoid build errors:

drivers/video/omap2/dss/dpi.c: In function 'dpi_calc_pll_cb':
drivers/video/omap2/dss/dpi.c:181:2: error: implicit declaration of function 'dsi_hsdiv_calc' [-Werror=implicit-function-declaration]
drivers/video/omap2/dss/dpi.c: In function 'dpi_dsi_clk_calc':
drivers/video/omap2/dss/dpi.c:201:2: error: implicit declaration of function 'dsi_get_pll_clkin' [-Werror=implicit-function-declaration]

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/omap2/dss/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index cb0f145..4b30084 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -35,6 +35,7 @@ config OMAP2_DSS_COLLECT_IRQ_STATS
 
 config OMAP2_DSS_DPI
 	bool "DPI support"
+	depends on OMAP2_DSS_DSI
 	default y
 	help
 	  DPI Interface. This is the Parallel Display Interface.
-- 
1.8.1.2
