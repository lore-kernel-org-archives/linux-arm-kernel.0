From: bhumirks@gmail.com (Bhumika Goyal)
Date: Wed, 16 Aug 2017 22:45:08 +0530
Subject: [PATCH 1/2] ASoC: bcm: make snd_soc_dai_driver const
In-Reply-To: <1502903709-7411-1-git-send-email-bhumirks@gmail.com>
References: <1502903709-7411-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502903709-7411-2-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/bcm/cygnus-ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index 1a57a4e..15c438f 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1165,7 +1165,7 @@ static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)
 	INIT_CPU_DAI(2),
 };
 
-static struct snd_soc_dai_driver cygnus_spdif_dai_info = {
+static const struct snd_soc_dai_driver cygnus_spdif_dai_info = {
 	.name = "cygnus-spdif",
 	.playback = {
 		.channels_min = 2,
-- 
1.9.1
