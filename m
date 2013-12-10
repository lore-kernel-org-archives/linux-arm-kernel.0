From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Dec 2013 15:19:04 -0800
Subject: [PATCH 2/2] gpio: msm: Add module device table and mark table const
In-Reply-To: <1386717544-478-1-git-send-email-sboyd@codeaurora.org>
References: <1386717544-478-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1386717544-478-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows the module to be loaded automatically.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/gpio/gpio-msm-v2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-msm-v2.c b/drivers/gpio/gpio-msm-v2.c
index 00a0978..a4dcbe4 100644
--- a/drivers/gpio/gpio-msm-v2.c
+++ b/drivers/gpio/gpio-msm-v2.c
@@ -430,10 +430,11 @@ static int msm_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id msm_gpio_of_match[] = {
+static const struct of_device_id msm_gpio_of_match[] = {
 	{ .compatible = "qcom,msm-gpio", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, msm_gpio_of_match);
 
 static int msm_gpio_remove(struct platform_device *dev)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
