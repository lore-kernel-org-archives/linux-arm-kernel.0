From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri,  6 Jul 2018 15:07:03 +0200
Subject: [PATCH] sound: stm32: replace "%p" with "%pK"
Message-ID: <20180706130703.22352-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The format specifier "%p" can leak kernel addresses.
Use "%pK" instead.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 sound/soc/stm/stm32_adfsdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index db73fef3e500..0e9373064032 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -149,7 +149,7 @@ static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *private)
 	unsigned int old_pos = priv->pos;
 	unsigned int cur_size = size;
 
-	dev_dbg(rtd->dev, "%s: buff_add :%p, pos = %d, size = %zu\n",
+	dev_dbg(rtd->dev, "%s: buff_add :%pK, pos = %d, size = %zu\n",
 		__func__, &pcm_buff[priv->pos], priv->pos, size);
 
 	if ((priv->pos + size) > buff_size) {
-- 
2.15.0
