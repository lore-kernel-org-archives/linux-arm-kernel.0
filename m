From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Thu, 22 Mar 2018 02:09:25 +0000
Subject: [PATCH -next] staging: mt7621-gpio: mt7621: make symbol gc_map static
Message-ID: <1521684565-76447-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following sparse warning:

drivers/staging/mt7621-gpio/gpio-mt7621.c:47:3: warning:
 symbol 'gc_map' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/staging/mt7621-gpio/gpio-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-gpio/gpio-mt7621.c b/drivers/staging/mt7621-gpio/gpio-mt7621.c
index 5c57abe..d00c1cd 100644
--- a/drivers/staging/mt7621-gpio/gpio-mt7621.c
+++ b/drivers/staging/mt7621-gpio/gpio-mt7621.c
@@ -38,7 +38,7 @@ enum mediatek_gpio_reg {
 static int mediatek_gpio_irq;
 static struct irq_domain *mediatek_gpio_irq_domain;
 
-struct mtk_gc {
+static struct mtk_gc {
 	struct gpio_chip chip;
 	spinlock_t lock;
 	int bank;
