From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 26 Dec 2016 11:34:33 +0900
Subject: [PATCH] clk: uniphier: remove unneeded #include <linux/delay.h>
Message-ID: <1482719673-17573-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This include was needed to suppress build error when this driver
was initially merged because <linux/regmap.h> did not include
<linux/delay.h> at that time.  (developers' headache across
sub-systems)

The root cause has been fixed by commit adf08d481b52 ("regmap:
include <linux/delay.h> from include/linux/regmap.h"), so this
line can be dropped now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

This patch must be applied on v4.10-rc1 or later
so that you can see both commit d08f1f0d596c and adf08d481b52.


 drivers/clk/uniphier/clk-uniphier-cpugear.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-cpugear.c b/drivers/clk/uniphier/clk-uniphier-cpugear.c
index 9bff26e..ec11f55 100644
--- a/drivers/clk/uniphier/clk-uniphier-cpugear.c
+++ b/drivers/clk/uniphier/clk-uniphier-cpugear.c
@@ -14,7 +14,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/regmap.h>
 
-- 
2.7.4
