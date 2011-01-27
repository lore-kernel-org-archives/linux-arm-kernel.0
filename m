From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 14:00:24 +0100
Subject: [PATCH 04/13] ARM i.MX31 mx31ads: remove unnecessary
	CONFIG_SERIAL_IMX ifdefs
In-Reply-To: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
References: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296133233-1062-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mach-mx31ads.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index f9a7109..1a83dc5 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -117,7 +117,6 @@ static inline int mxc_init_extuart(void)
 }
 #endif
 
-#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -134,11 +133,6 @@ static inline void mxc_init_imx_uart(void)
 	mxc_iomux_setup_multiple_pins(uart_pins, ARRAY_SIZE(uart_pins), "uart-0");
 	imx31_add_imx_uart0(&uart_pdata);
 }
-#else /* !SERIAL_IMX */
-static inline void mxc_init_imx_uart(void)
-{
-}
-#endif /* !SERIAL_IMX */
 
 static void mx31ads_expio_irq_handler(u32 irq, struct irq_desc *desc)
 {
-- 
1.7.2.3
