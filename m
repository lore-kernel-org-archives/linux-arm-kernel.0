From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Thu, 18 Feb 2010 23:11:33 +0200
Subject: [PATCH 1/2] Gemini: wrong registers used to set reg_level in
	gpio_set_irq_type()
In-Reply-To: <20100218211126.5646.39087.stgit@localhost.localdomain>
References: <20100218211126.5646.39087.stgit@localhost.localdomain>
Message-ID: <20100218211133.5646.49891.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roel Kluin <roel.kluin@gmail.com>

It appears the wrong GPIO registers were used

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---

 arch/arm/mach-gemini/gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-gemini/gpio.c b/arch/arm/mach-gemini/gpio.c
index e726385..fe3bd5a 100644
--- a/arch/arm/mach-gemini/gpio.c
+++ b/arch/arm/mach-gemini/gpio.c
@@ -86,7 +86,7 @@ static int gpio_set_irq_type(unsigned int irq, unsigned int type)
 	unsigned int reg_both, reg_level, reg_type;
 
 	reg_type = __raw_readl(base + GPIO_INT_TYPE);
-	reg_level = __raw_readl(base + GPIO_INT_BOTH_EDGE);
+	reg_level = __raw_readl(base + GPIO_INT_LEVEL);
 	reg_both = __raw_readl(base + GPIO_INT_BOTH_EDGE);
 
 	switch (type) {
@@ -117,7 +117,7 @@ static int gpio_set_irq_type(unsigned int irq, unsigned int type)
 	}
 
 	__raw_writel(reg_type, base + GPIO_INT_TYPE);
-	__raw_writel(reg_level, base + GPIO_INT_BOTH_EDGE);
+	__raw_writel(reg_level, base + GPIO_INT_LEVEL);
 	__raw_writel(reg_both, base + GPIO_INT_BOTH_EDGE);
 
 	gpio_ack_irq(irq);
