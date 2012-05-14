From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 14 May 2012 19:06:39 +0800
Subject: [PATCH 4/5] pinctrl: pinctrl-mxs: remove empty pinmux disable function
In-Reply-To: <1336993600-30065-1-git-send-email-b29396@freescale.com>
References: <1336993600-30065-1-git-send-email-b29396@freescale.com>
Message-ID: <1336993600-30065-4-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 drivers/pinctrl/pinctrl-mxs.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mxs.c b/drivers/pinctrl/pinctrl-mxs.c
index 93cd959..e10eff7 100644
--- a/drivers/pinctrl/pinctrl-mxs.c
+++ b/drivers/pinctrl/pinctrl-mxs.c
@@ -203,18 +203,11 @@ static int mxs_pinctrl_enable(struct pinctrl_dev *pctldev, unsigned selector,
 	return 0;
 }
 
-static void mxs_pinctrl_disable(struct pinctrl_dev *pctldev,
-				unsigned function, unsigned group)
-{
-	/* Nothing to do here */
-}
-
 static struct pinmux_ops mxs_pinmux_ops = {
 	.get_functions_count = mxs_pinctrl_get_funcs_count,
 	.get_function_name = mxs_pinctrl_get_func_name,
 	.get_function_groups = mxs_pinctrl_get_func_groups,
 	.enable = mxs_pinctrl_enable,
-	.disable = mxs_pinctrl_disable,
 };
 
 static int mxs_pinconf_get(struct pinctrl_dev *pctldev,
-- 
1.7.0.4
