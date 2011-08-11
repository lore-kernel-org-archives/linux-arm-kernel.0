From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 11 Aug 2011 14:43:22 -0600
Subject: [PATCH v2 2/4] gpio/tegra: Implement gpio_chip.to_irq
In-Reply-To: <1313095404-27858-1-git-send-email-swarren@nvidia.com>
References: <1313095404-27858-1-git-send-email-swarren@nvidia.com>
Message-ID: <1313095404-27858-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/gpio/gpio-tegra.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index ecade29..df64536 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -134,7 +134,10 @@ static int tegra_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
 	return 0;
 }
 
-
+static int tegra_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	return TEGRA_GPIO_TO_IRQ(offset);
+}
 
 static struct gpio_chip tegra_gpio_chip = {
 	.label			= "tegra-gpio",
@@ -142,6 +145,7 @@ static struct gpio_chip tegra_gpio_chip = {
 	.get			= tegra_gpio_get,
 	.direction_output	= tegra_gpio_direction_output,
 	.set			= tegra_gpio_set,
+	.to_irq			= tegra_gpio_to_irq,
 	.base			= 0,
 	.ngpio			= TEGRA_NR_GPIOS,
 };
-- 
1.7.0.4
