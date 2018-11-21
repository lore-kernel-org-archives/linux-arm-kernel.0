From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 21 Nov 2018 10:35:12 +0100
Subject: [PATCH 01/12] ARM: davinci: da8xx: define gpio interrupts as separate
 resources
In-Reply-To: <20181121093523.12503-1-brgl@bgdev.pl>
References: <20181121093523.12503-1-brgl@bgdev.pl>
Message-ID: <20181121093523.12503-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since commit eb3744a2dd01 ("gpio: davinci: Do not assume continuous
IRQ numbering") the davinci GPIO driver fails to probe if we boot
in legacy mode from any of the board files. Since the driver now
expects every interrupt to be defined as a separate resource, split
the definition of IRQ resources instead of having a single continuous
interrupt range.

Fixes: eb3744a2dd01 ("gpio: davinci: Do not assume continuous IRQ numbering")
Cc: stable at vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 1fd3619f6a09..cf78da5ab054 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -701,6 +701,46 @@ static struct resource da8xx_gpio_resources[] = {
 	},
 	{ /* interrupt */
 		.start	= IRQ_DA8XX_GPIO0,
+		.end	= IRQ_DA8XX_GPIO0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO1,
+		.end	= IRQ_DA8XX_GPIO1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO2,
+		.end	= IRQ_DA8XX_GPIO2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO3,
+		.end	= IRQ_DA8XX_GPIO3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO4,
+		.end	= IRQ_DA8XX_GPIO4,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO5,
+		.end	= IRQ_DA8XX_GPIO5,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO6,
+		.end	= IRQ_DA8XX_GPIO6,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO7,
+		.end	= IRQ_DA8XX_GPIO7,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_GPIO8,
 		.end	= IRQ_DA8XX_GPIO8,
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
2.19.1
