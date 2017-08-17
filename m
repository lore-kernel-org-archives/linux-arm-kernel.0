From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Aug 2017 18:12:58 +0100
Subject: Applied "ASoC: sh: make snd_soc_ops const" to the asoc tree
In-Reply-To: <1502902770-3758-8-git-send-email-bhumirks@gmail.com>
Message-ID: <E1diOLq-0008Kf-J9@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sh: make snd_soc_ops const

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

>From a46d0592d164c017342d2d86e5d123735ec046ae Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Wed, 16 Aug 2017 22:29:30 +0530
Subject: [PATCH] ASoC: sh: make snd_soc_ops const

Make this const as it is only stored in the ops field of a
snd_soc_dai_link structure, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/migor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index 672bcd4c252b..ecb057ff9fbb 100644
--- a/sound/soc/sh/migor.c
+++ b/sound/soc/sh/migor.c
@@ -98,7 +98,7 @@ static int migor_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_soc_ops migor_dai_ops = {
+static const struct snd_soc_ops migor_dai_ops = {
 	.hw_params = migor_hw_params,
 	.hw_free = migor_hw_free,
 };
-- 
2.13.3
