From: bhumirks@gmail.com (Bhumika Goyal)
Date: Wed, 16 Aug 2017 22:29:26 +0530
Subject: [PATCH 3/7] ASoC: generic: make snd_soc_ops const
In-Reply-To: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
References: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502902770-3758-4-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const as they are only stored in the ops field of a
snd_soc_dai_link structure, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/generic/audio-graph-card.c     | 2 +-
 sound/soc/generic/audio-graph-scu-card.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index de2550c..2f7c8cf 100644
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
index 758ac06..06b6fcf 100644
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
1.9.1
