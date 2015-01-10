From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 10 Jan 2015 22:51:52 +0100
Subject: [PATCH] pinctrl: pass -DDEBUG in subdirs
Message-ID: <1420926712-13447-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When drivers are compiled in subdirectories the -DDEBUG flag need
to be passed in the individual Makefiles.

Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Suggested-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This replaces Mika's patch too.
---
 drivers/pinctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index c030b3db8034..c7139ba195fe 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -1,6 +1,6 @@
 # generic pinmux support
 
-ccflags-$(CONFIG_DEBUG_PINCTRL)	+= -DDEBUG
+subdir-ccflags-$(CONFIG_DEBUG_PINCTRL)	+= -DDEBUG
 
 obj-$(CONFIG_PINCTRL)		+= core.o pinctrl-utils.o
 obj-$(CONFIG_PINMUX)		+= pinmux.o
-- 
1.9.3
