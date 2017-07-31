From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 31 Jul 2017 15:21:06 +0900
Subject: [PATCH 1/6] pinctrl: uniphier: remove unneeded EXPORT_SYMBOL_GPL()
In-Reply-To: <1501482071-9819-1-git-send-email-yamada.masahiro@socionext.com>
References: <1501482071-9819-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1501482071-9819-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All UniPhier pinctrl drivers are built-in.  Exporting the symbol
is meaningless.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index 30dec0ee7f35..c649e835bd54 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -13,7 +13,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/export.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/pinctrl/pinconf.h>
@@ -731,4 +730,3 @@ int uniphier_pinctrl_probe(struct platform_device *pdev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(uniphier_pinctrl_probe);
-- 
2.7.4
