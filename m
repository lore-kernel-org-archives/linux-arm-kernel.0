From: tony@atomide.com (Tony Lindgren)
Date: Wed, 06 Jan 2010 16:19:23 -0800
Subject: [PATCH 04/12] omap: Remove uninitialized warning for gpio.c
In-Reply-To: <20100107001728.21352.38471.stgit@baageli.muru.com>
References: <20100107001728.21352.38471.stgit@baageli.muru.com>
Message-ID: <20100107001923.21352.78020.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Flags is not used on 15xx.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index f8dfa8d..d17620c 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1117,7 +1117,7 @@ static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int ena
  */
 static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 {
-	unsigned long flags;
+	unsigned long uninitialized_var(flags);
 
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP16XX
