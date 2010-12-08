From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Wed, 8 Dec 2010 11:07:54 +0530
Subject: [PATCH 2/9] nomadik-gpio: use dev name if no name is specified
In-Reply-To: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
References: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1291786681-8664-2-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platforms may choose not to provide an additional name for the GPIO
block.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 5fc8e4d..eda4e3a 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -672,7 +672,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 
 	chip = &nmk_chip->chip;
 	chip->base = pdata->first_gpio;
-	chip->label = pdata->name;
+	chip->label = pdata->name ?: dev_name(&dev->dev);
 	chip->dev = &dev->dev;
 	chip->owner = THIS_MODULE;
 
-- 
1.7.2.dirty
