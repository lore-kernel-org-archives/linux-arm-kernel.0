From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Mar 2014 10:33:36 +0100
Subject: [PATCH] pinctrl: msm: fix build bug
Message-ID: <201403151033.36878.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 051a58b4622 "pinctrl: msm: Simplify msm_config_reg()
and callers" rearranged code in the msm_config_reg function, but
apparantly missed one line that was added in ed118a5fd9
"pinctrl-msm: Support output-{high,low} configuration".

This (untested) patch does the same respective change to
resolve the conflict.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>

diff --git a/drivers/pinctrl/pinctrl-msm.c b/drivers/pinctrl/pinctrl-msm.c
index 19d2feb..343f421 100644
--- a/drivers/pinctrl/pinctrl-msm.c
+++ b/drivers/pinctrl/pinctrl-msm.c
@@ -215,7 +215,6 @@ static int msm_config_reg(struct msm_pinctrl *pctrl,
 		*mask = 7;
 		break;
 	case PIN_CONFIG_OUTPUT:
-		*reg = g->ctl_reg;
 		*bit = g->oe_bit;
 		*mask = 1;
 		break;
