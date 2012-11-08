From: avinashphilip@ti.com (Philip, Avinash)
Date: Thu, 8 Nov 2012 13:23:14 +0530
Subject: [PATCH v2 07/10] pwm: pwm-tiehrpwm: pinctrl support
In-Reply-To: <1352361197-27442-1-git-send-email-avinashphilip@ti.com>
References: <1352361197-27442-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1352361197-27442-8-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pinctrl for pwm-tiehrpwm

Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
---
:100644 100644 fba7f9b... 07911e6... M	drivers/pwm/pwm-tiehrpwm.c
 drivers/pwm/pwm-tiehrpwm.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index fba7f9b..07911e6 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "tipwmss.h"
 
@@ -418,6 +419,11 @@ static int __devinit ehrpwm_pwm_probe(struct platform_device *pdev)
 	struct resource *r;
 	struct clk *clk;
 	struct ehrpwm_pwm_chip *pc;
+	struct pinctrl *pinctrl;
+
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev, "failed to configure pins from driver\n");
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
 	if (!pc) {
-- 
1.7.0.4
