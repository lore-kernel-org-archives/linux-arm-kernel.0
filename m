From: olivier.moysan@st.com (Olivier Moysan)
Date: Wed, 31 Jan 2018 17:47:02 +0100
Subject: [PATCH 1/2] ASoC: stm32: spdifrx: fix typo in function name.
In-Reply-To: <1517417223-21899-1-git-send-email-olivier.moysan@st.com>
References: <1517417223-21899-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1517417223-21899-2-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix function name prefix for naming consistency.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_spdifrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index b9bdefc..42ad2ae 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -858,8 +858,8 @@ static void stm32_spdifrx_shutdown(struct snd_pcm_substream *substream,
 	{}
 };
 
-static int stm_spdifrx_parse_of(struct platform_device *pdev,
-				struct stm32_spdifrx_data *spdifrx)
+static int stm32_spdifrx_parse_of(struct platform_device *pdev,
+				  struct stm32_spdifrx_data *spdifrx)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id;
@@ -914,7 +914,7 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spdifrx);
 
-	ret = stm_spdifrx_parse_of(pdev, spdifrx);
+	ret = stm32_spdifrx_parse_of(pdev, spdifrx);
 	if (ret)
 		return ret;
 
-- 
1.9.1
