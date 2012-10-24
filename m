From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 24 Oct 2012 10:58:57 +0400
Subject: [PATCH] GPIO: clps711x: Fix return value for gpio_clps711x_get
Message-ID: <1351061937-11629-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/gpio/gpio-clps711x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
index ea21822..0753b3a 100644
--- a/drivers/gpio/gpio-clps711x.c
+++ b/drivers/gpio/gpio-clps711x.c
@@ -47,7 +47,7 @@ static void __iomem *clps711x_pdirs[] = {
 
 static int gpio_clps711x_get(struct gpio_chip *chip, unsigned offset)
 {
-	return !!readb(clps711x_port(chip)) & (1 << offset);
+	return !!(readb(clps711x_port(chip)) & (1 << offset));
 }
 
 static void gpio_clps711x_set(struct gpio_chip *chip, unsigned offset,
-- 
1.7.3.4
