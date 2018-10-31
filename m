From: colin.king@canonical.com (Colin King)
Date: Wed, 31 Oct 2018 18:42:41 +0000
Subject: [PATCH] pinctrl: mediatek: clean up indentation issues,
 add missing tab
Message-ID: <20181031184241.5439-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to clean up indentation issues, add one level of
indentation on two if statements.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c | 4 ++--
 drivers/pinctrl/mediatek/pinctrl-paris.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index 3133ec0f2e67..aa1068d2867f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -310,8 +310,8 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		case PIN_CONFIG_DRIVE_STRENGTH:
 			if (hw->soc->drive_set) {
 				err = hw->soc->drive_set(hw, desc, arg);
-			if (err)
-				return err;
+				if (err)
+					return err;
 			} else {
 				err = -ENOTSUPP;
 			}
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index d2179028f134..50e68b1e9065 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -282,8 +282,8 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		if (hw->soc->drive_set) {
 			err = hw->soc->drive_set(hw, desc, arg);
-		if (err)
-			return err;
+			if (err)
+				return err;
 		} else {
 			return -ENOTSUPP;
 		}
-- 
2.19.1
