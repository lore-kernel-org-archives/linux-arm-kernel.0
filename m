From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 2 Mar 2012 16:53:41 +0100
Subject: [PATCH] pinctrl: fix the pin descriptor kerneldoc
Message-ID: <1330703621-4044-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The introduction of the owner field on the pin descriptor was not
properly documented so fix this up.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/core.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index 97f8124..e1dfdb3 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -76,9 +76,7 @@ struct pinctrl {
  *	datasheet or such
  * @dynamic_name: if the name of this pin was dynamically allocated
  * @lock: a lock to protect the descriptor structure
- * @mux_requested: whether the pin is already requested by pinmux or not
- * @mux_function: a named muxing function for the pin that will be passed to
- *	subdrivers and shown in debugfs etc
+ * @owner: the device holding this pin or NULL of no device has claimed it
  */
 struct pin_desc {
 	struct pinctrl_dev *pctldev;
-- 
1.7.8
