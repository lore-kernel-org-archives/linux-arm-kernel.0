From: colin.king@canonical.com (Colin King)
Date: Wed, 14 Feb 2018 16:10:36 +0000
Subject: [PATCH][next] ASoC: uniphier: remove redundant check of blk_id
Message-ID: <20180214161036.32446-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

The check of blk_id == AUD_CLK_IO is redundant as it also being performed
in the following switch statement with the same return of -ENOTSUPP. Fix
this by removing the redundant comparison.

Detected by CoverityScan, CID#1465227 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/uniphier/aio-cpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index 55f3248a31fd..7cf2316c69a2 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -134,9 +134,6 @@ static int uniphier_aio_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	bool pll_auto = false;
 	int pll_id, div_id;
 
-	if (clk_id == AUD_CLK_IO)
-		return -ENOTSUPP;
-
 	switch (clk_id) {
 	case AUD_CLK_IO:
 		return -ENOTSUPP;
-- 
2.15.1
