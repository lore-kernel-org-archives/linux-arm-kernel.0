From: broonie@kernel.org (Mark Brown)
Date: Thu, 07 Jul 2016 12:00:58 +0200
Subject: Applied "ASoC: atmel_ssc_dai: Fix DMA params for different SSC" to
 the asoc tree
In-Reply-To: <20160705094629.5326-1-pmeerw@pmeerw.net>
Message-ID: <E1bL678-0000gj-2j@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: atmel_ssc_dai: Fix DMA params for different SSC

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From e401029e514b6ba94d21212a957de6010581f17a Mon Sep 17 00:00:00 2001
From: Peter Meerwald <p.meerwald@bct-electronic.com>
Date: Tue, 5 Jul 2016 11:46:29 +0200
Subject: [PATCH] ASoC: atmel_ssc_dai: Fix DMA params for different SSC

follow-up patch from c706f2e55f ASoC: atmel_ssc_dai: distinguish the
different SSC

cpu_dai id is always 0, use platform_device id to distinguish DMA
parameters of SSCs

Signed-off-by: Peter Meerwald-Stadler <p.meerwald@bct-electronic.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel_ssc_dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 1267e1af0fae..54c09acd3fed 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -321,7 +321,7 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	dma_params = &ssc_dma_params[dai->id][dir];
+	dma_params = &ssc_dma_params[pdev->id][dir];
 	dma_params->ssc = ssc_p->ssc;
 	dma_params->substream = substream;
 
-- 
2.8.1
