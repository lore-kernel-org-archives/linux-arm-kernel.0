From: gururaja.hebbar@ti.com (Hebbar Gururaja)
Date: Thu, 31 Jan 2013 16:53:11 +0530
Subject: [PATCH v3 2/4] ASoC: davinci: update machine driver dapm routes
In-Reply-To: <1359631394-9511-1-git-send-email-gururaja.hebbar@ti.com>
References: <1359631394-9511-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1359631394-9511-3-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now since micbias is converted to supply widget, updated machine driver
as well.

Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
---
Changes in v3
	 - New patch

:100644 100644 d55e647... 484b22c... M	sound/soc/davinci/davinci-evm.c
 sound/soc/davinci/davinci-evm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index d55e647..484b22c 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -116,9 +116,9 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Line Out", NULL, "RLOUT"},
 
 	/* Mic connected to (MIC3L | MIC3R) */
-	{"MIC3L", NULL, "Mic Bias 2V"},
-	{"MIC3R", NULL, "Mic Bias 2V"},
-	{"Mic Bias 2V", NULL, "Mic Jack"},
+	{"MIC3L", NULL, "Mic Bias"},
+	{"MIC3R", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Mic Jack"},
 
 	/* Line In connected to (LINE1L | LINE2L), (LINE1R | LINE2R) */
 	{"LINE1L", NULL, "Line In"},
-- 
1.7.9.5
