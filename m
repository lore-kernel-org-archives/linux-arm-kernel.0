From: bhumirks@gmail.com (Bhumika Goyal)
Date: Wed, 16 Aug 2017 22:29:27 +0530
Subject: [PATCH 4/7] ASoC: pxa: make snd_soc_ops const
In-Reply-To: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
References: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502902770-3758-5-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only stored in the ops field of a
snd_soc_dai_link structure, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/pxa/raumfeld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 111a907..43f6ab7 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -196,7 +196,7 @@ static int raumfeld_ak4104_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops raumfeld_ak4104_ops = {
+static const struct snd_soc_ops raumfeld_ak4104_ops = {
 	.hw_params = raumfeld_ak4104_hw_params,
 };
 
-- 
1.9.1
