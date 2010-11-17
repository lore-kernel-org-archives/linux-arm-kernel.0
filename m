From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:41 +0100
Subject: [PATCH 13/51] ARM: imx/gpio: remove some useless casts
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-13-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 9c3e362..a43d9cc 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -175,7 +175,7 @@ static void mxc_gpio_irq_handler(struct mxc_gpio_port *port, u32 irq_stat)
 static void mx3_gpio_irq_handler(u32 irq, struct irq_desc *desc)
 {
 	u32 irq_stat;
-	struct mxc_gpio_port *port = (struct mxc_gpio_port *)get_irq_data(irq);
+	struct mxc_gpio_port *port = get_irq_data(irq);
 
 	irq_stat = __raw_readl(port->base + GPIO_ISR) &
 			__raw_readl(port->base + GPIO_IMR);
@@ -188,7 +188,7 @@ static void mx2_gpio_irq_handler(u32 irq, struct irq_desc *desc)
 {
 	int i;
 	u32 irq_msk, irq_stat;
-	struct mxc_gpio_port *port = (struct mxc_gpio_port *)get_irq_data(irq);
+	struct mxc_gpio_port *port = get_irq_data(irq);
 
 	/* walk through all interrupt status registers */
 	for (i = 0; i < gpio_table_size; i++) {
-- 
1.7.2.3
