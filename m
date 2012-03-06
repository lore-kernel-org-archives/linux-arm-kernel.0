From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Mar 2012 23:25:36 +0100
Subject: [PATCH] pinctrl: include machine header to core.h
In-Reply-To: <4F565C04.1030202@ru.mvista.com>
References: <1331038557-1398-1-git-send-email-linus.walleij@stericsson.com>
 <4F565C04.1030202@ru.mvista.com>
Message-ID: <CACRpkdYdzTBiHKod+tzM4tPbYgRaNU=aRdqCnTQ6urqbT4vayQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 7:48 PM, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> ? I don't see where you touch kernel-doc...

Bah, missed to git add it. Here is the new patch:

>From 872acc322c74bb06b7ceb61fe93314e2da32362c Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 6 Mar 2012 13:52:22 +0100
Subject: [PATCH] pinctrl: include machine header to core.h

struct pinctrl_setting contains an enum pinctrl_map_type
field, so we need to include machine.h. Also fix kerneldoc
to indicate that the pinctrl_setting is about both muxing
and other config.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/core.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index 5b3ff13..efbfb62 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/radix-tree.h>
 #include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/machine.h>

 struct pinctrl_gpio_range;

@@ -96,7 +97,7 @@ struct pinctrl_setting_configs {
 };

 /**
- * struct pinctrl_setting - an individual mux setting
+ * struct pinctrl_setting - an individual mux or config setting
  * @node: list node for struct pinctrl_settings's @settings field
  * @type: the type of setting
  * @pctldev: pin control device handling to be programmed
-- 
1.7.8
