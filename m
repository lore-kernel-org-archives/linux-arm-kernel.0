From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:08 +0100
Subject: [PATCH 13/39] arm/imx: use generic_handle_irq instead of open-coding
	it
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-13-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/gpio.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 3cba1dd..bee100b 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -171,8 +171,7 @@ static void mxc_gpio_irq_handler(struct mxc_gpio_port *port, u32 irq_stat)
 		if (port->both_edges & (1 << (gpio & 31)))
 			mxc_flip_edge(port, gpio);
 
-		irq_desc[gpio_irq_no].handle_irq(gpio_irq_no,
-				&irq_desc[gpio_irq_no]);
+		generic_handle_irq(gpio_irq_no);
 	}
 }
 
-- 
1.6.6.2
