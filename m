From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri,  6 Jul 2018 15:03:55 +0200
Subject: [PATCH] media: stm32: dcmi: replace "%p" with "%pK"
Message-ID: <20180706130355.22100-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The format specifier "%p" can leak kernel addresses.
Use "%pK" instead.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 2e1933d872ee..fe90672cf16f 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1753,7 +1753,7 @@ static int dcmi_probe(struct platform_device *pdev)
 
 	ret = clk_prepare(mclk);
 	if (ret) {
-		dev_err(&pdev->dev, "Unable to prepare mclk %p\n", mclk);
+		dev_err(&pdev->dev, "Unable to prepare mclk %pK\n", mclk);
 		goto err_dma_release;
 	}
 
-- 
2.15.0
