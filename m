From: olivier.moysan@st.com (olivier moysan)
Date: Fri, 16 Jun 2017 14:15:31 +0200
Subject: [PATCH 4/7] ASoC: stm32: sai: remove spurious trace
In-Reply-To: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
References: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1497615334-7156-5-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove spurious trace in sai driver.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index d7aeed3..24b8874 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -761,9 +761,6 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 		return -ENODEV;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	dev_err(&pdev->dev, "res %pr\n", res);
-
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
-- 
1.9.1
