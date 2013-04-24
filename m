From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 24 Apr 2013 16:25:34 +0200
Subject: [PATCH] pinctrl/pinconfig: fix misplaced goto
Message-ID: <1366813534-2460-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Meunier <laurent.meunier@st.com>

This update contains a basic fix that went unseen through
test and review.

Signed-off-by: Laurent Meunier <laurent.meunier@st.com>
Reviewed-by: Patrice Chotard <patrice.chotard@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index 3578667..c67c37e 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -771,8 +771,8 @@ static int pinconf_dbg_config_write(struct file *file,
 	}
 
 	if (!found) {
-		goto exit;
 		count = -EINVAL;
+		goto exit;
 	}
 
 	if (pctldev)
-- 
1.7.11.3
