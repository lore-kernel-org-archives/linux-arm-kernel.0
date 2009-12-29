From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Wed, 30 Dec 2009 00:51:30 +0200
Subject: [patch-v2.6.33-rc2+ 10/12] arm: omap: gpio: kill compile warning in
	gpio.c
In-Reply-To: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
References: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
Message-ID: <1262127092-14878-11-git-send-email-felipe.balbi@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when building linux-omap for omap1510, there will
be a compile warning about the unused flags variable
which is only used on 16xx and onwards.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/gpio.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 0484681..8c34b81 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1072,7 +1072,10 @@ static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int ena
  */
 static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 {
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || \
+	defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 	unsigned long flags;
+#endif
 
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP16XX
-- 
1.6.6.35.g1d85d
