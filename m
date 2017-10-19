From: olivier.moysan@st.com (Olivier Moysan)
Date: Thu, 19 Oct 2017 15:03:22 +0200
Subject: [INTERNAL][PATCH 6/7] ASoC: stm32: sai: Fix get reset controller
In-Reply-To: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
References: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1508418203-16840-7-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm version of reset_control_get function
to manage driver removing properly.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 1258bef..5fe878ac 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -85,7 +85,7 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	}
 
 	/* reset */
-	rst = reset_control_get_exclusive(&pdev->dev, NULL);
+	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (!IS_ERR(rst)) {
 		reset_control_assert(rst);
 		udelay(2);
-- 
1.9.1
