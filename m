From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 9 Dec 2010 22:08:32 +0800
Subject: [PATCH 2/6] arm: plat-mxc: add full parameter macro to define gpio
	port
In-Reply-To: <1291903716-31388-1-git-send-email-richard.zhao@freescale.com>
References: <1291903716-31388-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1291903716-31388-2-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/plat-mxc/gpio.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 93a8d93..235985e 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -350,15 +350,18 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 	return 0;
 }
 
-#define DEFINE_IMX_GPIO_PORT_IRQ(soc, _id, _hwid, _irq)			\
+#define _DEFINE_IMX_GPIO_PORT_IRQ(soc, _id, _hwid, _irq, _irq_high)	\
 	{								\
 		.chip.label = "gpio-" #_id,				\
 		.irq = _irq,						\
+		.irq_high = _irq_high,					\
 		.base = soc ## _IO_ADDRESS(				\
 				soc ## _GPIO ## _hwid ## _BASE_ADDR),	\
 		.virtual_irq_start = MXC_GPIO_IRQ_START + (_id) * 32,	\
 	}
 
+#define DEFINE_IMX_GPIO_PORT_IRQ(soc, _id, _hwid, _irq)			\
+	_DEFINE_IMX_GPIO_PORT_IRQ(soc, _id, _hwid, _irq, 0)
 #define DEFINE_IMX_GPIO_PORT(soc, _id, _hwid)				\
 	DEFINE_IMX_GPIO_PORT_IRQ(soc, _id, _hwid, 0)
 
-- 
1.6.3.3
