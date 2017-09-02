From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  3 Sep 2017 02:26:18 +0900
Subject: [PATCH] pinctrl: uniphier: include <linux/build_bug.h> instead of
 <linux/bug.h>
Message-ID: <1504373178-1022-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The #includes <linux/bug.h> is here to use BUILD_BUG_ON_ZERO().

Thanks to commit bc6245e5efd7 ("bug: split BUILD_BUG stuff out into
<linux/build_bug.h>"), it is now possible to reduce the number of
headers pulled in.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier.h b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
index c075ecb8e5db..0a3d2ac27503 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier.h
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
@@ -17,7 +17,7 @@
 #define __PINCTRL_UNIPHIER_H__
 
 #include <linux/bitops.h>
-#include <linux/bug.h>
+#include <linux/build_bug.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 
-- 
2.7.4
