From: alan@signal11.us (Alan Ott)
Date: Thu,  1 Mar 2012 14:26:43 -0500
Subject: [PATCH 1/8] ARM: tegra: export tegra_gpio_{en,dis}able
In-Reply-To: <1330630010-11241-1-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
Message-ID: <1330630010-11241-2-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

These two functions are used in drivers that can be
modules, so they need to be exported.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-tegra.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index bdc2937..96662cc 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -107,11 +107,13 @@ void tegra_gpio_enable(int gpio)
 {
 	tegra_gpio_mask_write(GPIO_MSK_CNF(gpio), gpio, 1);
 }
+EXPORT_SYMBOL_GPL(tegra_gpio_enable);
 
 void tegra_gpio_disable(int gpio)
 {
 	tegra_gpio_mask_write(GPIO_MSK_CNF(gpio), gpio, 0);
 }
+EXPORT_SYMBOL_GPL(tegra_gpio_disable);
 
 static void tegra_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-- 
1.7.0.4
