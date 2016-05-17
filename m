From: colin.king@canonical.com (Colin King)
Date: Tue, 17 May 2016 17:26:55 +0100
Subject: [PATCH] pinctrl: stm32: fix incorrect pinctl format message
Message-ID: <1463502415-17920-1-git-send-email-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

There are missing string format specifiers in the seq_printf
that are causing a build warning.  Add these missing string
format specifiers to fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index e51c1cf..ae9fab8 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -794,7 +794,7 @@ static void stm32_pconf_dbg_show(struct pinctrl_dev *pctldev,
 	case 2:
 		drive = stm32_pconf_get_driving(bank, offset);
 		speed = stm32_pconf_get_speed(bank, offset);
-		seq_printf(s, "%d - %s -%s", alt,
+		seq_printf(s, "%d - %s - %s - %s %s", alt,
 			   drive ? "open drain" : "push pull",
 			   biasing[bias],
 			   speeds[speed], "speed");
-- 
2.8.1
