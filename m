From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Aug 2017 18:12:55 +0100
Subject: Applied "ASoC: bcm: make snd_soc_dai_driver const" to the asoc tree
In-Reply-To: <1502903709-7411-2-git-send-email-bhumirks@gmail.com>
Message-ID: <E1diOLn-0008JO-HS@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: bcm: make snd_soc_dai_driver const

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

>From cc6e25631ddd4f3295fc79568f2145c437849e63 Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Wed, 16 Aug 2017 22:45:08 +0530
Subject: [PATCH] ASoC: bcm: make snd_soc_dai_driver const

Make this const as it is only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/cygnus-ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index e710bb0c5637..cdd5e82439dd 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1288,7 +1288,7 @@ static const struct snd_soc_dai_driver cygnus_ssp_dai_info[] = {
 	INIT_CPU_DAI(2),
 };
 
-static struct snd_soc_dai_driver cygnus_spdif_dai_info = {
+static const struct snd_soc_dai_driver cygnus_spdif_dai_info = {
 	.name = "cygnus-spdif",
 	.playback = {
 		.channels_min = 2,
-- 
2.13.3
