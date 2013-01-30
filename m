From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 30 Jan 2013 20:40:06 +0100
Subject: [PATCH 2/4] pinctrl/abx500: replace incorrect return value
Message-ID: <1359574806-15661-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

Currently in the empty abx500_pin_config_get() function, we're
returning -EINVAL, with a comment stating that the reason for the
failure is that the function isn't implemented yet. Well there's
a proper return code for that. If we use it, we can do away with
the comment too, as it would be implied.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-abx500.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-abx500.c b/drivers/pinctrl/pinctrl-abx500.c
index 539c9bb..305a9cb 100644
--- a/drivers/pinctrl/pinctrl-abx500.c
+++ b/drivers/pinctrl/pinctrl-abx500.c
@@ -971,8 +971,7 @@ int abx500_pin_config_get(struct pinctrl_dev *pctldev,
 		       unsigned pin,
 		       unsigned long *config)
 {
-	/* Not implemented */
-	return -EINVAL;
+	return -ENOSYS;
 }
 
 int abx500_pin_config_set(struct pinctrl_dev *pctldev,
-- 
1.7.11.3
