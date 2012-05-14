From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 14 May 2012 19:06:40 +0800
Subject: [PATCH 5/5] pinctrl: pinctrl-pxa3xx: remove empty pinmux disable
 function
In-Reply-To: <1336993600-30065-1-git-send-email-b29396@freescale.com>
References: <1336993600-30065-1-git-send-email-b29396@freescale.com>
Message-ID: <1336993600-30065-5-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 drivers/pinctrl/pinctrl-pxa3xx.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-pxa3xx.c b/drivers/pinctrl/pinctrl-pxa3xx.c
index 7644e42..f14cd6b 100644
--- a/drivers/pinctrl/pinctrl-pxa3xx.c
+++ b/drivers/pinctrl/pinctrl-pxa3xx.c
@@ -138,11 +138,6 @@ static int pxa3xx_pmx_enable(struct pinctrl_dev *pctrldev, unsigned func,
 	return 0;
 }
 
-static void pxa3xx_pmx_disable(struct pinctrl_dev *pctrldev, unsigned func,
-			       unsigned group)
-{
-}
-
 static int pxa3xx_pmx_request_gpio(struct pinctrl_dev *pctrldev,
 				   struct pinctrl_gpio_range *range,
 				   unsigned pin)
@@ -170,7 +165,6 @@ static struct pinmux_ops pxa3xx_pmx_ops = {
 	.get_function_name	= pxa3xx_pmx_get_func_name,
 	.get_function_groups	= pxa3xx_pmx_get_groups,
 	.enable			= pxa3xx_pmx_enable,
-	.disable		= pxa3xx_pmx_disable,
 	.gpio_request_enable	= pxa3xx_pmx_request_gpio,
 };
 
-- 
1.7.0.4
