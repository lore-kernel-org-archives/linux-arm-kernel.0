From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Thu, 26 Jun 2014 15:41:31 +0200
Subject: [PATCH] pinctrl: pinctrl-at91.c: Cleaning up values that are never
 used
Message-ID: <1403790091-11423-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove variable that are never used

This was found using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/pinctrl/pinctrl-at91.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 421493c..9854a29 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -793,9 +793,9 @@ static void at91_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 				   struct seq_file *s, unsigned pin_id)
 {
 	unsigned long config;
-	int ret, val, num_conf = 0;
+	int val, num_conf = 0;
 
-	ret = at91_pinconf_get(pctldev, pin_id, &config);
+	at91_pinconf_get(pctldev, pin_id, &config);
 
 	DBG_SHOW_FLAG(MULTI_DRIVE);
 	DBG_SHOW_FLAG(PULL_UP);
-- 
1.7.10.4
