From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 14 May 2012 19:06:38 +0800
Subject: [PATCH 3/5] pinctrl: pinctrl-imx: remove empty pinmux disable function
In-Reply-To: <1336993600-30065-1-git-send-email-b29396@freescale.com>
References: <1336993600-30065-1-git-send-email-b29396@freescale.com>
Message-ID: <1336993600-30065-3-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 drivers/pinctrl/pinctrl-imx.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index 8faf613..f6e7c67 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -269,12 +269,6 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
 	return 0;
 }
 
-static void imx_pmx_disable(struct pinctrl_dev *pctldev, unsigned func_selector,
-			    unsigned group_selector)
-{
-	/* nothing to do here */
-}
-
 static int imx_pmx_get_funcs_count(struct pinctrl_dev *pctldev)
 {
 	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
@@ -310,7 +304,6 @@ static struct pinmux_ops imx_pmx_ops = {
 	.get_function_name = imx_pmx_get_func_name,
 	.get_function_groups = imx_pmx_get_groups,
 	.enable = imx_pmx_enable,
-	.disable = imx_pmx_disable,
 };
 
 static int imx_pinconf_get(struct pinctrl_dev *pctldev,
-- 
1.7.0.4
