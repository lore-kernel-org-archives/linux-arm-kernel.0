From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri,  6 Jul 2018 15:08:08 +0200
Subject: [PATCH] watchdog: stm32: replace "%p" with "%pK"
Message-ID: <20180706130808.22466-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The format specifier "%p" can leak kernel addresses.
Use "%pK" instead.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/watchdog/stm32_iwdg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index c97ad5619cb0..740f74a98644 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -172,7 +172,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		dev_err(&pdev->dev, "Unable to prepare clock %p\n", clk);
+		dev_err(&pdev->dev, "Unable to prepare clock %pK\n", clk);
 		return ret;
 	}
 
-- 
2.15.0
