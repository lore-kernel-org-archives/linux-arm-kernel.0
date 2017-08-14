From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 14 Aug 2017 17:08:50 +0530
Subject: [PATCH 11/11] ASoC: soc-utils: make snd_soc_platform_driver const
In-Reply-To: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502710730-18912-12-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only passed as the 2nd argument to the function
snd_soc_register_platform, which is of type const.
Done using Coccinelle

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/soc-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 644d9a9..e30aacb 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -284,7 +284,7 @@ static int dummy_dma_open(struct snd_pcm_substream *substream)
 	.ioctl		= snd_pcm_lib_ioctl,
 };
 
-static struct snd_soc_platform_driver dummy_platform = {
+static const struct snd_soc_platform_driver dummy_platform = {
 	.ops = &dummy_dma_ops,
 };
 
-- 
1.9.1
