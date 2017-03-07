From: broonie@kernel.org (Mark Brown)
Date: Tue, 07 Mar 2017 15:21:22 +0100
Subject: Applied "ASoC: atmel-classd: fix audio clock rate" to the asoc tree
In-Reply-To: <20170224071043.25522-1-songjun.wu@microchip.com>
Message-ID: <E1clFzO-0006cY-F7@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: atmel-classd: fix audio clock rate

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

>From cd3ac9affc43b44f49d7af70d275f0bd426ba643 Mon Sep 17 00:00:00 2001
From: Songjun Wu <songjun.wu@microchip.com>
Date: Fri, 24 Feb 2017 15:10:43 +0800
Subject: [PATCH] ASoC: atmel-classd: fix audio clock rate

Fix the audio clock rate according to the datasheet.

Reported-by: Dushara Jayasinghe <dushara@successful.com.au>
Signed-off-by: Songjun Wu <songjun.wu@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable at vger.kernel.org
---
 sound/soc/atmel/atmel-classd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 89ac5f5a93eb..7ae46c2647d4 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -349,7 +349,7 @@ static int atmel_classd_codec_dai_digital_mute(struct snd_soc_dai *codec_dai,
 }
 
 #define CLASSD_ACLK_RATE_11M2896_MPY_8 (112896 * 100 * 8)
-#define CLASSD_ACLK_RATE_12M288_MPY_8  (12228 * 1000 * 8)
+#define CLASSD_ACLK_RATE_12M288_MPY_8  (12288 * 1000 * 8)
 
 static struct {
 	int rate;
-- 
2.11.0
