From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Sat, 20 Aug 2016 01:05:37 +0300
Subject: [PATCH] pinctrl: imx: output one pin/config pair per line in
 pinconf-groups
Message-ID: <1471644337-10162-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cat /sys/kernel/debug/pinctrl/${pinctrl}/pinconf-groups output is
hardly readable, if a pin group contains more than one pin the output
is glued and looks like this:

  MX6Q_PAD_SD1_DAT0: 0x17071MX6Q_PAD_SD1_CMD: 0x17071MX6Q_PAD_SD1_CLK: 0x17071

Add two space indentation and a new line separator to improve
readability of the output.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 71391757938b..56fd88013850 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -501,7 +501,7 @@ static void imx_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 		ret = imx_pinconf_get(pctldev, pin->pin, &config);
 		if (ret)
 			return;
-		seq_printf(s, "%s: 0x%lx", name, config);
+		seq_printf(s, "  %s: 0x%lx\n", name, config);
 	}
 }
 
-- 
2.8.1
