From: tony@atomide.com (Tony Lindgren)
Date: Fri,  5 May 2017 15:37:06 -0700
Subject: [PATCH] memory: omap-gpmc: Fix debug output for access width
Message-ID: <20170505223706.4913-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The width needs to be configured in bytes with 1 meaning 8-bit
access and 2 meaning 16-bit access.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/memory/omap-gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -513,7 +513,7 @@ static void gpmc_cs_show_timings(int cs, const char *desc)
 	pr_info("gpmc cs%i access configuration:\n", cs);
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1,  4,  4, "time-para-granularity");
 	GPMC_GET_RAW(GPMC_CS_CONFIG1,  8,  9, "mux-add-data");
-	GPMC_GET_RAW_MAX(GPMC_CS_CONFIG1, 12, 13,
+	GPMC_GET_RAW_SHIFT_MAX(GPMC_CS_CONFIG1, 12, 13, 1,
 			 GPMC_CONFIG1_DEVICESIZE_MAX, "device-width");
 	GPMC_GET_RAW(GPMC_CS_CONFIG1, 16, 17, "wait-pin");
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 21, 21, "wait-on-write");
-- 
2.12.2
