From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri,  4 Aug 2017 13:01:25 +0900
Subject: [PATCH] pinctrl: uniphier: widen all pinconf-derived arguments to u32
Message-ID: <1501819285-12827-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 58957d2edfa1 ("pinctrl: Widen the generic pinconf argument
from 16 to 24 bits"), the generic pinconf arguments are handled by u32.

UniPhier pinctrl drivers do not support debouncing, so u16 is working,
but align the argument type to u32 for consistency.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index 5d8c9efd8135..f9267fabe6b0 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -198,7 +198,7 @@ static int uniphier_conf_pin_bias_get(struct pinctrl_dev *pctldev,
 }
 
 static int uniphier_conf_pin_drive_get(struct pinctrl_dev *pctldev,
-				       unsigned int pin, u16 *strength)
+				       unsigned int pin, u32 *strength)
 {
 	struct uniphier_pinctrl_priv *priv = pinctrl_dev_get_drvdata(pctldev);
 	const struct pin_desc *desc = pin_desc_get(pctldev, pin);
@@ -289,7 +289,7 @@ static int uniphier_conf_pin_config_get(struct pinctrl_dev *pctldev,
 {
 	enum pin_config_param param = pinconf_to_config_param(*configs);
 	bool has_arg = false;
-	u16 arg;
+	u32 arg;
 	int ret;
 
 	switch (param) {
@@ -393,7 +393,7 @@ static int uniphier_conf_pin_bias_set(struct pinctrl_dev *pctldev,
 }
 
 static int uniphier_conf_pin_drive_set(struct pinctrl_dev *pctldev,
-				       unsigned int pin, u16 strength)
+				       unsigned int pin, u32 strength)
 {
 	struct uniphier_pinctrl_priv *priv = pinctrl_dev_get_drvdata(pctldev);
 	const struct pin_desc *desc = pin_desc_get(pctldev, pin);
@@ -454,7 +454,7 @@ static int uniphier_conf_pin_drive_set(struct pinctrl_dev *pctldev,
 }
 
 static int uniphier_conf_pin_input_enable(struct pinctrl_dev *pctldev,
-					  unsigned int pin, u16 enable)
+					  unsigned int pin, u32 enable)
 {
 	struct uniphier_pinctrl_priv *priv = pinctrl_dev_get_drvdata(pctldev);
 	const struct pin_desc *desc = pin_desc_get(pctldev, pin);
-- 
2.7.4
