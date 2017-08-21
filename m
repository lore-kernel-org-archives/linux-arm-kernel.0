From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 21 Aug 2017 18:02:46 +0200
Subject: [PATCH v2 01/16] mmc: meson-gx: fix mux mask definition
In-Reply-To: <20170821160301.21899-1-jbrunet@baylibre.com>
References: <20170821160301.21899-1-jbrunet@baylibre.com>
Message-ID: <20170821160301.21899-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CCF generic mux will shift the mask using the value defined in shift
Define the mask accordingly

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index de962c2d5e00..4217287923d4 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -366,7 +366,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	init.num_parents = MUX_CLK_NUM_PARENTS;
 	host->mux.reg = host->regs + SD_EMMC_CLOCK;
 	host->mux.shift = __bf_shf(CLK_SRC_MASK);
-	host->mux.mask = CLK_SRC_MASK;
+	host->mux.mask = CLK_SRC_MASK >> host->mux.shift;
 	host->mux.flags = 0;
 	host->mux.table = NULL;
 	host->mux.hw.init = &init;
-- 
2.9.5
