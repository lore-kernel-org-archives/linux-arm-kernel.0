From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 10 May 2011 11:21:00 -0300
Subject: [PATCH] ARM: imx/mach-apf9328: Simplify UART0 registration
Message-ID: <1305037260-31131-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As no flag is passed into UART0 platform data, pass NULL argument 
when registering UART0.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-apf9328.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/mach-apf9328.c b/arch/arm/mach-imx/mach-apf9328.c
index 15e45c8..c11d0ab 100644
--- a/arch/arm/mach-imx/mach-apf9328.c
+++ b/arch/arm/mach-imx/mach-apf9328.c
@@ -99,11 +99,6 @@ static struct platform_device dm9000x_device = {
 	}
 };
 
-/* --- SERIAL RESSOURCE --- */
-static const struct imxuart_platform_data uart0_pdata __initconst = {
-	.flags = 0,
-};
-
 static const struct imxuart_platform_data uart1_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -119,7 +114,7 @@ static void __init apf9328_init(void)
 			ARRAY_SIZE(apf9328_pins),
 			"APF9328");
 
-	imx1_add_imx_uart0(&uart0_pdata);
+	imx1_add_imx_uart0(NULL);
 	imx1_add_imx_uart1(&uart1_pdata);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
-- 
1.6.0.4
