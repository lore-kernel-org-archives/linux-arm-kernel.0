From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 31 May 2016 15:30:10 +0900
Subject: [PATCH] pinctrl: uniphier: fix .pin_dbg_show() callback
Message-ID: <1464676210-16508-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this, reading the "pins" in the debugfs causes kernel BUG.

Fixes: 6e9088920258 ("pinctrl: UniPhier: add UniPhier pinctrl core support")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Hi Linus,
I hope this will be applied as a bug-fix patch for Linux 4.7 .

 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index 9674009..5d08de0 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -73,6 +73,12 @@ static void uniphier_pctl_pin_dbg_show(struct pinctrl_dev *pctldev,
 	case UNIPHIER_PIN_PULL_DOWN:
 		pull_dir = "DOWN";
 		break;
+	case UNIPHIER_PIN_PULL_UP_FIXED:
+		pull_dir = "UP(FIXED)";
+		break;
+	case UNIPHIER_PIN_PULL_DOWN_FIXED:
+		pull_dir = "DOWN(FIXED)";
+		break;
 	case UNIPHIER_PIN_PULL_NONE:
 		pull_dir = "NONE";
 		break;
-- 
1.9.1
