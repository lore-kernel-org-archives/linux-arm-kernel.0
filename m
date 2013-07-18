From: davidb@codeaurora.org (David Brown)
Date: Thu, 18 Jul 2013 13:07:14 -0700
Subject: [PATCH 2/3] drivers: gpio: msm: Fix the error condition for reading
 ngpio
In-Reply-To: <1374178035-19943-1-git-send-email-davidb@codeaurora.org>
References: <1374178035-19943-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1374178035-19943-3-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rohit Vaswani <rvaswani@codeaurora.org>

of_property_read_u32 return 0 on success. The check was using a ! to
return error. Fix the if condition.

Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Pankaj Jangra  <jangra.pankaj9@gmail.com>
Cc: "Bird, Tim" <Tim.Bird@sonymobile.com>
Signed-off-by: David Brown <davidb@codeaurora.org>
---
 drivers/gpio/gpio-msm-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-msm-v2.c b/drivers/gpio/gpio-msm-v2.c
index f4491a4..c2fa770 100644
--- a/drivers/gpio/gpio-msm-v2.c
+++ b/drivers/gpio/gpio-msm-v2.c
@@ -378,7 +378,7 @@ static int msm_gpio_probe(struct platform_device *pdev)
 	int ret, ngpio;
 	struct resource *res;
 
-	if (!of_property_read_u32(pdev->dev.of_node, "ngpio", &ngpio)) {
+	if (of_property_read_u32(pdev->dev.of_node, "ngpio", &ngpio)) {
 		dev_err(&pdev->dev, "%s: ngpio property missing\n", __func__);
 		return -EINVAL;
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
