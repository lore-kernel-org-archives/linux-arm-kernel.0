From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  4 Jun 2013 12:20:00 -0700
Subject: [PATCH] gpio: msm-v1: Remove errant __devinit to fix compile
Message-ID: <1370373600-31921-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7bce696 (gpio: Make gpio-msm-v1 into a platform driver,
2013-03-04) was based on an older kernel where __devinit still
existed. Remove the erroneous __devinit marking.

Cc: David Brown <davidb@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/gpio/gpio-msm-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-msm-v1.c b/drivers/gpio/gpio-msm-v1.c
index c798585a..fb2cc90 100644
--- a/drivers/gpio/gpio-msm-v1.c
+++ b/drivers/gpio/gpio-msm-v1.c
@@ -630,7 +630,7 @@ static struct irq_chip msm_gpio_irq_chip = {
 	.irq_set_type  = msm_gpio_irq_set_type,
 };
 
-static int __devinit gpio_msm_v1_probe(struct platform_device *pdev)
+static int gpio_msm_v1_probe(struct platform_device *pdev)
 {
 	int i, j = 0;
 	const struct platform_device_id *dev_id = platform_get_device_id(pdev);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
