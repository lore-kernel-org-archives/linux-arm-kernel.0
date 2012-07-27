From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 27 Jul 2012 19:18:42 +0800
Subject: [PATCH 1/1] ASoC: sgtl5000: enable VAG_POWER for LINE_IN
Message-ID: <1343387922-25227-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

LINE_IN also needs VAG_POWER on or we may hear noise when directly
route LINE_IN to Headphone Mux.
Tested on imx28evk.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 sound/soc/codecs/sgtl5000.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 5c54b6f..df2f99d 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -239,6 +239,7 @@ static const struct snd_soc_dapm_route sgtl5000_dapm_routes[] = {
 	{"Headphone Mux", "DAC", "DAC"},	/* dac --> hp_mux */
 	{"LO", NULL, "DAC"},			/* dac --> line_out */
 
+	{"LINE_IN", NULL, "VAG_POWER"},
 	{"Headphone Mux", "LINE_IN", "LINE_IN"},/* line_in --> hp_mux */
 	{"HP", NULL, "Headphone Mux"},		/* hp_mux --> hp */
 
-- 
1.7.0.4
