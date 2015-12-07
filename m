From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:32 +0000
Subject: [PATCH 19/19] mfd: davinci_voicecodec: Remove pointless 'out of
 memory' error message
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-20-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: Possible unnecessary 'out of memory' message
+       if (!davinci_vc) {
+               dev_dbg(&pdev->dev,

total: 0 errors, 1 warnings, 154 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/davinci_voicecodec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mfd/davinci_voicecodec.c b/drivers/mfd/davinci_voicecodec.c
index 9bbc642..dff2f19 100644
--- a/drivers/mfd/davinci_voicecodec.c
+++ b/drivers/mfd/davinci_voicecodec.c
@@ -47,11 +47,8 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
 
 	davinci_vc = devm_kzalloc(&pdev->dev,
 				  sizeof(struct davinci_vc), GFP_KERNEL);
-	if (!davinci_vc) {
-		dev_dbg(&pdev->dev,
-			    "could not allocate memory for private data\n");
+	if (!davinci_vc)
 		return -ENOMEM;
-	}
 
 	davinci_vc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(davinci_vc->clk)) {
-- 
1.9.1
