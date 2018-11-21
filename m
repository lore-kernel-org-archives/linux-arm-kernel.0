From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 21 Nov 2018 10:35:13 +0100
Subject: [PATCH 02/12] ARM: davinci: dm365: define gpio interrupts as separate
 resources
In-Reply-To: <20181121093523.12503-1-brgl@bgdev.pl>
References: <20181121093523.12503-1-brgl@bgdev.pl>
Message-ID: <20181121093523.12503-3-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/dm365.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index abcf2a5ed89b..42665914166a 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -267,6 +267,41 @@ static struct resource dm365_gpio_resources[] = {
 	},
 	{	/* interrupt */
 		.start	= IRQ_DM365_GPIO0,
+		.end	= IRQ_DM365_GPIO0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO1,
+		.end	= IRQ_DM365_GPIO1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO2,
+		.end	= IRQ_DM365_GPIO2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO3,
+		.end	= IRQ_DM365_GPIO3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO4,
+		.end	= IRQ_DM365_GPIO4,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO5,
+		.end	= IRQ_DM365_GPIO5,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO6,
+		.end	= IRQ_DM365_GPIO6,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO7,
 		.end	= IRQ_DM365_GPIO7,
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
2.19.1
