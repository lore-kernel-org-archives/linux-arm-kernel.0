From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Feb 2018 15:34:15 +0000
Subject: Applied "ASoC: uniphier: remove redundant check of blk_id" to the
 asoc tree
In-Reply-To: <20180214161036.32446-1-colin.king@canonical.com>
Message-ID: <E1emLY7-0007KZ-Mh@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: uniphier: remove redundant check of blk_id

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 53b8e4504aaa7fc88fd18e6caac3a4d4367bd4a4 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 14 Feb 2018 16:10:36 +0000
Subject: [PATCH] ASoC: uniphier: remove redundant check of blk_id

The check of blk_id == AUD_CLK_IO is redundant as it also being performed
in the following switch statement with the same return of -ENOTSUPP. Fix
this by removing the redundant comparison.

Detected by CoverityScan, CID#1465227 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.16.1
