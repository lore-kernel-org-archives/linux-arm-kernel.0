From: yamada.m@jp.panasonic.com (Masahiro Yamada)
Date: Wed, 24 Dec 2014 14:38:16 +0900
Subject: [PATCH] linux/kernel.h: merge ARRAY_AND_SIZE defines
Message-ID: <1419399496-5955-1-git-send-email-yamada.m@jp.panasonic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARRAY_AND_SIZE is a useful macro.  Its definition is already
duplicated in some headers.  Move it to include/linux/kernel.h.

Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
---

 arch/arm/mach-mmp/common.h        | 1 -
 arch/arm/mach-pxa/generic.h       | 2 --
 arch/arm/mach-ux500/db8500-regs.h | 2 --
 drivers/pinctrl/pinctrl-lantiq.h  | 2 --
 include/linux/kernel.h            | 1 +
 5 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index cf445ba..e503f63 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -1,5 +1,4 @@
 #include <linux/reboot.h>
-#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
 
 extern void timer_init(int irq);
 
diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 7a9fa1a..da11977 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -23,8 +23,6 @@ extern void pxa_timer_init(void);
 	mi->bank[__nr].start = (__start), \
 	mi->bank[__nr].size = (__size)
 
-#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
-
 #define pxa25x_handle_irq icip_handle_irq
 extern void __init pxa25x_init_irq(void);
 extern void __init pxa25x_map_io(void);
diff --git a/arch/arm/mach-ux500/db8500-regs.h b/arch/arm/mach-ux500/db8500-regs.h
index 2739955..80a6deb 100644
--- a/arch/arm/mach-ux500/db8500-regs.h
+++ b/arch/arm/mach-ux500/db8500-regs.h
@@ -195,6 +195,4 @@
 /* Used by some plat-nomadik code */
 #define io_p2v(n)		__io_address(n)
 
-#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
-
 #endif
diff --git a/drivers/pinctrl/pinctrl-lantiq.h b/drivers/pinctrl/pinctrl-lantiq.h
index c7cfad5..508d205 100644
--- a/drivers/pinctrl/pinctrl-lantiq.h
+++ b/drivers/pinctrl/pinctrl-lantiq.h
@@ -21,8 +21,6 @@
 
 #include "core.h"
 
-#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
-
 #define LTQ_MAX_MUX		4
 #define MFPR_FUNC_MASK		0x3
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 049d43b..4e8fc3d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -59,6 +59,7 @@ void printch(int c);
 #define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
+#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
 
 /*
  * This looks more complex than it should be. But we need to
-- 
1.9.1
