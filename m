From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 15 Dec 2017 19:00:46 +0100
Subject: [PATCH] pwm: atmel-tcb: Delete an error message for a failed memory
 allocation in atmel_tcb_pwm_probe()
Message-ID: <8274c498-1d1b-2ece-365c-98ded714a53c@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 15 Dec 2017 18:55:11 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/pwm/pwm-atmel-tcb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index acd3ce8ecf3f..4fb1be246c44 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -401,7 +401,6 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	tcbpwm = devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
 	if (tcbpwm == NULL) {
 		err = -ENOMEM;
-		dev_err(&pdev->dev, "failed to allocate memory\n");
 		goto err_free_tc;
 	}
 
-- 
2.15.1
