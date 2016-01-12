From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jan 2016 10:02:04 +0100
Subject: [PATCH] mfd: asic3: remove extraneous ')'
Message-ID: <5507931.oM3h7nKshR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A cleanup patch introduced an extra closing ')' that leads to a
build error:

drivers/mfd/asic3.c: In function 'asic3_gpio_get':
drivers/mfd/asic3.c:505:12: error: expected ';' before ')' token

This removes the extra character to get it to build again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: fd5b4d01a638 ("mfd: asic3: Be sure to clamp return value")
---
This came up today on linux-next. I took the liberty to adjust formatting
of that line as well, if you prefer the original line wrapping please
undo that part when applying.

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index c8d46e51faf1..4dca6bc61f5b 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -501,8 +501,8 @@ static int asic3_gpio_get(struct gpio_chip *chip,
 		return -EINVAL;
 	}
 
-	return !!(asic3_read_register(asic, gpio_base + ASIC3_GPIO_STATUS)
-		  & mask));
+	return !!(asic3_read_register(asic,
+				      gpio_base + ASIC3_GPIO_STATUS) & mask);
 }
 
 static void asic3_gpio_set(struct gpio_chip *chip,
