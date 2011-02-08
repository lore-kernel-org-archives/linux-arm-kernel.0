From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 Feb 2011 10:20:51 +0100
Subject: [PATCH 6/9] plat-nomadik: type secondary IRQ correctly
In-Reply-To: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
References: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1297156854-32295-7-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>

Coverity found that we were checking an unsigned variable for
greater than zero. Type it correctly.

Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 71682a8..cc9de59 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -53,7 +53,7 @@ struct nmk_gpio_chip {
 	struct clk *clk;
 	unsigned int bank;
 	unsigned int parent_irq;
-	unsigned int secondary_parent_irq;
+	int secondary_parent_irq;
 	u32 (*get_secondary_status)(unsigned int bank);
 	spinlock_t lock;
 	/* Keep track of configured edges */
-- 
1.7.3.2
