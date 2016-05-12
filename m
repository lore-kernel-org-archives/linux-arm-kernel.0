From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Thu, 12 May 2016 16:46:34 +0200
Subject: [PATCH 1/2] pinctrl: stm32: fix warning
In-Reply-To: <1463064395-4669-1-git-send-email-patrice.chotard@st.com>
References: <1463064395-4669-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1463064395-4669-2-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

fix compilation warning :
drivers/pinctrl/stm32/pinctrl-stm32.c:823:7: warning: too many arguments for format [-Wformat-extra-args]
           speeds[speed], "speed");

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 1527740..249da52 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -806,21 +806,21 @@ static void stm32_pconf_dbg_show(struct pinctrl_dev *pctldev,
 		drive = stm32_pconf_get_driving(bank, offset);
 		speed = stm32_pconf_get_speed(bank, offset);
 		val = stm32_pconf_output_get(bank, offset);
-		seq_printf(s, "- %s - %s - %s - %s %s",
+		seq_printf(s, "- %s - %s - %s - %s speed",
 			   val ? "high" : "low",
 			   drive ? "open drain" : "push pull",
 			   biasing[bias],
-			   speeds[speed], "speed");
+			   speeds[speed]);
 		break;
 
 	/* alternate */
 	case 2:
 		drive = stm32_pconf_get_driving(bank, offset);
 		speed = stm32_pconf_get_speed(bank, offset);
-		seq_printf(s, "%d - %s -%s", alt,
+		seq_printf(s, "%d - %s -%s - %s speed", alt,
 			   drive ? "open drain" : "push pull",
 			   biasing[bias],
-			   speeds[speed], "speed");
+			   speeds[speed]);
 		break;
 
 	/* analog */
-- 
1.9.1
