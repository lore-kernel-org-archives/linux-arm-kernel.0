From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Sep 2012 15:02:39 +0200
Subject: [PATCH 16/16] ARM: spear: move platform_data definitions
In-Reply-To: <1347368559-31329-1-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368559-31329-1-git-send-email-arnd@arndb.de>
Message-ID: <1347368559-31329-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform data for device drivers should be defined in
include/linux/platform_data/*.h, not in the architecture
and platform specific directories.

This moves such data out of the spear include directories

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: spear-devel at list.st.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/spear-keyboard.c                              |    2 +-
 .../plat/keyboard.h => include/linux/platform_data/keyboard-spear.h  |    0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/plat-spear/include/plat/keyboard.h => include/linux/platform_data/keyboard-spear.h (100%)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 72ef01b..c7ca97f 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -24,7 +24,7 @@
 #include <linux/pm_wakeup.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <plat/keyboard.h>
+#include <linux/platform_data/keyboard-spear.h>
 
 /* Keyboard Registers */
 #define MODE_CTL_REG	0x00
diff --git a/arch/arm/plat-spear/include/plat/keyboard.h b/include/linux/platform_data/keyboard-spear.h
similarity index 100%
rename from arch/arm/plat-spear/include/plat/keyboard.h
rename to include/linux/platform_data/keyboard-spear.h
-- 
1.7.10
