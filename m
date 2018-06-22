From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 Jun 2018 15:50:32 +0100
Subject: Applied "ASoC: uniphier: remove redundant check of PLL ID" to the
 asoc tree
In-Reply-To: <20180621025628.4046-1-suzuki.katsuhiro@socionext.com>
Message-ID: <E1fWNOS-0002fp-81@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: uniphier: remove redundant check of PLL ID

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

>From 366f074d047b2538cc5d7e4a820bb6c117a3ccec Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Thu, 21 Jun 2018 11:56:28 +0900
Subject: [PATCH] ASoC: uniphier: remove redundant check of PLL ID

This patch removes redudant check of PLL ID. struct uniphier_aio_pll
enable member has already been checked at is_valid_pll().

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/aio-cpu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index 2d9b7dde2ffa..ee90e6c3937c 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -219,15 +219,10 @@ static int uniphier_aio_set_pll(struct snd_soc_dai *dai, int pll_id,
 				unsigned int freq_out)
 {
 	struct uniphier_aio *aio = uniphier_priv(dai);
-	struct device *dev = &aio->chip->pdev->dev;
 	int ret;
 
 	if (!is_valid_pll(aio->chip, pll_id))
 		return -EINVAL;
-	if (!aio->chip->plls[pll_id].enable) {
-		dev_err(dev, "PLL(%d) is not implemented\n", pll_id);
-		return -ENOTSUPP;
-	}
 
 	ret = aio_chip_set_pll(aio->chip, pll_id, freq_out);
 	if (ret < 0)
-- 
2.18.0.rc2
