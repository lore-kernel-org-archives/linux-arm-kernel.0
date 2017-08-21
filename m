From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 21 Aug 2017 18:02:48 +0200
Subject: [PATCH v2 03/16] mmc: meson-gx: clean up some constants
In-Reply-To: <20170821160301.21899-1-jbrunet@baylibre.com>
References: <20170821160301.21899-1-jbrunet@baylibre.com>
Message-ID: <20170821160301.21899-4-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused clock rate defines. These should not be defined but
requested from the clock framework.

Also correct typo on the DELAY register

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index d480a8052a06..8a74a048db88 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -45,9 +45,7 @@
 #define   CLK_DIV_MAX 63
 #define   CLK_SRC_MASK GENMASK(7, 6)
 #define   CLK_SRC_XTAL 0   /* external crystal */
-#define   CLK_SRC_XTAL_RATE 24000000
 #define   CLK_SRC_PLL 1    /* FCLK_DIV2 */
-#define   CLK_SRC_PLL_RATE 1000000000
 #define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
 #define   CLK_TX_PHASE_MASK GENMASK(11, 10)
 #define   CLK_RX_PHASE_MASK GENMASK(13, 12)
@@ -57,7 +55,7 @@
 #define   CLK_PHASE_270 3
 #define   CLK_ALWAYS_ON BIT(24)
 
-#define SD_EMMC_DElAY 0x4
+#define SD_EMMC_DELAY 0x4
 #define SD_EMMC_ADJUST 0x8
 #define SD_EMMC_CALOUT 0x10
 #define SD_EMMC_START 0x40
-- 
2.9.5
