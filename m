From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:10 +0100
Subject: [PATCH 15/39] arm/imx/gpio: remove a BUG_ON in hot path
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-15-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now if the problem occurs that triggered the BUG_ON before, the machine
runs in a NULL pointer dereference.  So it wouldn't be much harder now
to debug the situation if it occured.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/gpio.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 0b11554..70b2389 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -162,8 +162,6 @@ static void mxc_gpio_irq_handler(struct mxc_gpio_port *port, u32 irq_stat)
 	while (irq_stat != 0) {
 		int irqoffset = fls(irq_stat) - 1;
 
-		BUG_ON(!(irq_desc[gpio_irq_no_base + irqoffset].handle_irq));
-
 		if (port->both_edges & (1 << irqoffset))
 			mxc_flip_edge(port, irqoffset);
 
-- 
1.6.6.2
