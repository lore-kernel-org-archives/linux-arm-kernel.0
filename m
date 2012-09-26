From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 26 Sep 2012 15:01:04 +0200
Subject: [PATCH] pinctrl: clarify idle vs sleep states
Message-ID: <1348664464-12079-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This pure documentation fix tries to align the "idle" and
"sleep" pin states to the idle and suspend states from
runtime PM.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/pinctrl/pinctrl-state.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/pinctrl/pinctrl-state.h b/include/linux/pinctrl/pinctrl-state.h
index 634608dc..2dbf71d 100644
--- a/include/linux/pinctrl/pinctrl-state.h
+++ b/include/linux/pinctrl/pinctrl-state.h
@@ -6,13 +6,15 @@
  * @PINCTRL_STATE_DEFAULT: the state the pinctrl handle shall be put
  *	into as default, usually this means the pins are up and ready to
  *	be used by the device driver. This state is commonly used by
- *	hogs to configure muxing and pins at boot.
+ *	hogs to configure muxing and pins at boot, and also as a state
+ *	to go into when returning from sleep and idle in
+ *	.pm_runtime_resume() or ordinary .resume() for example.
  * @PINCTRL_STATE_IDLE: the state the pinctrl handle shall be put into
  *	when the pins are idle. Could typically be set from a
- *	pm_runtime_suspend() operation.
+ *	pm_runtime_idle() operation.
  * @PINCTRL_STATE_SLEEP: the state the pinctrl handle shall be put into
  *	when the pins are sleeping. Could typically be set from a
- *	common suspend() function.
+ *	common pm_runtime_suspend() or ordinary .suspend() function.
  */
 #define PINCTRL_STATE_DEFAULT "default"
 #define PINCTRL_STATE_IDLE "idle"
-- 
1.7.11.3
