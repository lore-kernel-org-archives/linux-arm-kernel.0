From: chunkeey@googlemail.com (Christian Lamparter)
Date: Thu, 28 Apr 2016 11:05:11 +0200
Subject: [RFC v4 1/8] gpio: generic: fix GPIO_GENERIC_PLATFORM is set to
 module case
In-Reply-To: <cover.1461806071.git.chunkeey@googlemail.com>
References: <cover.1461806071.git.chunkeey@googlemail.com>
Message-ID: <5891890cfc1c8ce45c310e3876485011518aeba9.1461806071.git.chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO_GENERIC_PLATFORM is a tristate. If the module option is
selected the resulting gpio-generic.ko will lack most of the
module initialzation and probe code.

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 drivers/gpio/gpio-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-generic.c
index 54cddfa..6c1cb3b 100644
--- a/drivers/gpio/gpio-generic.c
+++ b/drivers/gpio/gpio-generic.c
@@ -549,7 +549,7 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(bgpio_init);
 
-#ifdef CONFIG_GPIO_GENERIC_PLATFORM
+#if IS_ENABLED(CONFIG_GPIO_GENERIC_PLATFORM)
 
 static void __iomem *bgpio_map(struct platform_device *pdev,
 			       const char *name,
-- 
2.8.1
