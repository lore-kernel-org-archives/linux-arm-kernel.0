From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 16 Oct 2018 13:11:33 +0900
Subject: [PATCH] gpio: uniphier: include <linux/bits.h> instead of
 <linux/bitops.h>
Message-ID: <1539663093-15923-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reason of including <linux/bitops.h> here is just for BIT() and
GENMASK macros.

Since commit 8bd9cb51daac8 ("locking/atomics, asm-generic: Move some
macros from <linux/bitops.h> to a new <linux/bits.h> file"),
<linux/bits.h> is enough for such compile-time macros.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/gpio/gpio-uniphier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
index 7fdac90..74551cbd 100644
--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -12,7 +12,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/gpio/driver.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
-- 
2.7.4
