From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 21 Nov 2018 10:35:15 +0100
Subject: [PATCH 04/12] ARM: davinci: dm355: define gpio interrupts as separate
 resources
In-Reply-To: <20181121093523.12503-1-brgl@bgdev.pl>
References: <20181121093523.12503-1-brgl@bgdev.pl>
Message-ID: <20181121093523.12503-5-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/dm355.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 9f7d38d12c88..2b0f5d97ab7c 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -548,6 +548,36 @@ static struct resource dm355_gpio_resources[] = {
 	},
 	{	/* interrupt */
 		.start	= IRQ_DM355_GPIOBNK0,
+		.end	= IRQ_DM355_GPIOBNK0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK1,
+		.end	= IRQ_DM355_GPIOBNK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK2,
+		.end	= IRQ_DM355_GPIOBNK2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK3,
+		.end	= IRQ_DM355_GPIOBNK3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK4,
+		.end	= IRQ_DM355_GPIOBNK4,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK5,
+		.end	= IRQ_DM355_GPIOBNK5,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK6,
 		.end	= IRQ_DM355_GPIOBNK6,
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
2.19.1
