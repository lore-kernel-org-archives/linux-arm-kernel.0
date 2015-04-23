From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 23 Apr 2015 19:16:12 +0530
Subject: [RFC 6/7] clk: qcom: gcc-msm8960: add child devices support.
In-Reply-To: <1429796773-7151-1-git-send-email-rnayak@codeaurora.org>
References: <1429796773-7151-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1429796773-7151-7-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to add child devices to gcc as some of the
registers mapped by gcc are used by things like thermal sensors.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/clk/qcom/gcc-msm8960.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index eb6a4f9..2c80d03 100644
--- a/drivers/clk/qcom/gcc-msm8960.c
+++ b/drivers/clk/qcom/gcc-msm8960.c
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -3520,7 +3521,8 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	return qcom_cc_probe(pdev, match->data);
+	qcom_cc_probe(pdev, match->data);
+	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
 }
 
 static int gcc_msm8960_remove(struct platform_device *pdev)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
