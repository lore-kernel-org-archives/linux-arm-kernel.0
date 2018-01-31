From: olivier.moysan@st.com (Olivier Moysan)
Date: Wed, 31 Jan 2018 17:47:03 +0100
Subject: [PATCH 2/2] ASoC: stm32: spdifrx: Use default dai name
In-Reply-To: <1517417223-21899-1-git-send-email-olivier.moysan@st.com>
References: <1517417223-21899-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1517417223-21899-3-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dai name provided by framework from dev_name() function.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_spdifrx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 42ad2ae..373df4f 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -819,7 +819,6 @@ static void stm32_spdifrx_shutdown(struct snd_pcm_substream *substream,
 
 static struct snd_soc_dai_driver stm32_spdifrx_dai[] = {
 	{
-		.name = "spdifrx-capture-cpu-dai",
 		.probe = stm32_spdifrx_dai_probe,
 		.capture = {
 			.stream_name = "CPU-Capture",
-- 
1.9.1
