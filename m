From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 14 Aug 2017 17:08:49 +0530
Subject: [PATCH 10/11] ASoC: txx9: make snd_soc_platform_driver const
In-Reply-To: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502710730-18912-11-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only passed as the 2nd argument to the function
devm_snd_soc_register_platform, which is of type const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/txx9/txx9aclc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 7912bf0..7df95df 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -403,7 +403,7 @@ static int txx9aclc_pcm_remove(struct snd_soc_platform *platform)
 	return 0;
 }
 
-static struct snd_soc_platform_driver txx9aclc_soc_platform = {
+static const struct snd_soc_platform_driver txx9aclc_soc_platform = {
 	.probe		= txx9aclc_pcm_probe,
 	.remove		= txx9aclc_pcm_remove,
 	.ops		= &txx9aclc_pcm_ops,
-- 
1.9.1
