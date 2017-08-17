From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Aug 2017 18:13:08 +0100
Subject: Applied "ASoC: generic: make snd_soc_ops const" to the asoc tree
In-Reply-To: <1502902770-3758-4-git-send-email-bhumirks@gmail.com>
Message-ID: <E1diOM0-0008OR-Bl@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: generic: make snd_soc_ops const

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

>From e23d834876390d6b8d4d35057e9ecd899a44193a Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Wed, 16 Aug 2017 22:29:26 +0530
Subject: [PATCH] ASoC: generic: make snd_soc_ops const

Make these const as they are only stored in the ops field of a
snd_soc_dai_link structure, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c     | 2 +-
 sound/soc/generic/audio-graph-scu-card.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 105ec3a6e30d..d3497a3e14ca 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -95,7 +95,7 @@ static void asoc_graph_card_shutdown(struct snd_pcm_substream *substream)
 	asoc_simple_card_clk_disable(&dai_props->codec_dai);
 }
 
-static struct snd_soc_ops asoc_graph_card_ops = {
+static const struct snd_soc_ops asoc_graph_card_ops = {
 	.startup = asoc_graph_card_startup,
 	.shutdown = asoc_graph_card_shutdown,
 };
diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index dcd2df37bc3b..3da9acd6844e 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -56,7 +56,7 @@ static void asoc_graph_card_shutdown(struct snd_pcm_substream *substream)
 	asoc_simple_card_clk_disable(dai_props);
 }
 
-static struct snd_soc_ops asoc_graph_card_ops = {
+static const struct snd_soc_ops asoc_graph_card_ops = {
 	.startup = asoc_graph_card_startup,
 	.shutdown = asoc_graph_card_shutdown,
 };
-- 
2.13.3
