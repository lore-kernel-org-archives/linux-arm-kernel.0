From: olivier.moysan@st.com (Olivier Moysan)
Date: Thu, 2 Nov 2017 11:20:09 +0100
Subject: [PATCH 1/1] ASoC: stm32: sai: fix warning in stm32_sai_set_config()
Message-ID: <1509618009-30804-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix uninitialized warning introduced by
"Move static settings to DAI init" commit
in stm32_sai_set_config() function.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 150ad54..08583b9 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -482,13 +482,13 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 	cr1_mask = SAI_XCR1_DS_MASK;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
-		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_8);
+		cr1 = SAI_XCR1_DS_SET(SAI_DATASIZE_8);
 		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
-		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_16);
+		cr1 = SAI_XCR1_DS_SET(SAI_DATASIZE_16);
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
-		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_32);
+		cr1 = SAI_XCR1_DS_SET(SAI_DATASIZE_32);
 		break;
 	default:
 		dev_err(cpu_dai->dev, "Data format not supported");
-- 
1.9.1
