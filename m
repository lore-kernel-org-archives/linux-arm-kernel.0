From: bhumirks@gmail.com (Bhumika Goyal)
Date: Wed, 16 Aug 2017 22:29:30 +0530
Subject: [PATCH 7/7] ASoC: sh: make snd_soc_ops const
In-Reply-To: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
References: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502902770-3758-8-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only stored in the ops field of a
snd_soc_dai_link structure, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/sh/migor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index 672bcd4..ecb057f 100644
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
1.9.1
