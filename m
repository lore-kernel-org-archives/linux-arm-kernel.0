From: broonie@kernel.org (Mark Brown)
Date: Thu, 08 Dec 2016 16:55:08 +0000
Subject: Applied "ASoC: zte: spdif: correct ZX_SPDIF_CLK_RAT define" to the
 asoc tree
In-Reply-To: <1481186655-8213-2-git-send-email-shawnguo@kernel.org>
Message-ID: <E1cF1yO-0004we-Kg@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: zte: spdif: correct ZX_SPDIF_CLK_RAT define

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

>From 44b1c9a6e7a2692e761e35ada2ffe84b20c2a377 Mon Sep 17 00:00:00 2001
From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 8 Dec 2016 16:44:15 +0800
Subject: [PATCH] ASoC: zte: spdif: correct ZX_SPDIF_CLK_RAT define

The macro ZX_SPDIF_CLK_RAT should be 2 instead of 4.  With this
fix, we can get correct audio output on HDMI through SPDIF interface.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Jun Nie <jun.nie@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/zte/zx-spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/zte/zx-spdif.c b/sound/soc/zte/zx-spdif.c
index 26265ce4caca..9fa6463ce5d7 100644
--- a/sound/soc/zte/zx-spdif.c
+++ b/sound/soc/zte/zx-spdif.c
@@ -71,7 +71,7 @@
 #define ZX_VALID_RIGHT_TRACK		(2 << 0)
 #define ZX_VALID_TRACK_MASK		(3 << 0)
 
-#define ZX_SPDIF_CLK_RAT		(4 * 32)
+#define ZX_SPDIF_CLK_RAT		(2 * 32)
 
 struct zx_spdif_info {
 	struct snd_dmaengine_dai_dma_data	dma_data;
-- 
2.10.2
