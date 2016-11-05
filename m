From: xypron.glpk@gmx.de (Heinrich Schuchardt)
Date: Sat,  5 Nov 2016 15:25:15 +0100
Subject: [PATCH 1/1] pinctrl: st: st_pinconf_dbg_show wrong format string
Message-ID: <20161105142515.4377-1-xypron.glpk@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

function is defined as unsigned int.
So we need %u to print it.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/pinctrl/pinctrl-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index b7bb371..8308f15 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1006,7 +1006,7 @@ static void st_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 
 	function = st_pctl_get_pin_function(pc, offset);
 	if (function)
-		snprintf(f, 10, "Alt Fn %d", function);
+		snprintf(f, 10, "Alt Fn %u", function);
 	else
 		snprintf(f, 5, "GPIO");
 
-- 
2.10.1
