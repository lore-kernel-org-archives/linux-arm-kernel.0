From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 23 Nov 2017 19:01:49 +0900
Subject: [PATCH] gpio: uniphier: fix mismatch between license text and
 MODULE_LICENSE
Message-ID: <1511431310-9892-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comment block of this file indicates GPL-2.0 "only", while the
MODULE_LICENSE is GPL-2.0 "or later", as include/linux/module.h
describes as follows:

  "GPL"                           [GNU Public License v2 or later]
  "GPL v2"                        [GNU Public License v2]

I am the author of this driver, and my intention is GPL-2.0 "only".

Fixes: dbe776c2ca54 ("gpio: uniphier: add UniPhier GPIO controller driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/gpio/gpio-uniphier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
index 016d742..761d827 100644
--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -505,4 +505,4 @@ module_platform_driver(uniphier_gpio_driver);
 
 MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
 MODULE_DESCRIPTION("UniPhier GPIO driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
