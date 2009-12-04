From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Fri,  4 Dec 2009 15:44:06 -0200
Subject: [PATCH] mx27: mxt_td60: Remove not used UART pins
Message-ID: <1259948646-9808-1-git-send-email-acassis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alan Carvalho de Assis <acassis@gmail.com>
---
 arch/arm/mach-mx2/mxt_td60.c |   24 ------------------------
 1 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-mx2/mxt_td60.c b/arch/arm/mach-mx2/mxt_td60.c
index 03dbbdc..8bcc1a5 100644
--- a/arch/arm/mach-mx2/mxt_td60.c
+++ b/arch/arm/mach-mx2/mxt_td60.c
@@ -58,21 +58,6 @@ static unsigned int mxt_td60_pins[] __initdata = {
 	PE9_PF_UART3_RXD,
 	PE10_PF_UART3_CTS,
 	PE11_PF_UART3_RTS,
-	/* UART3 */
-	PB26_AF_UART4_RTS,
-	PB28_AF_UART4_TXD,
-	PB29_AF_UART4_CTS,
-	PB31_AF_UART4_RXD,
-	/* UART4 */
-	PB18_AF_UART5_TXD,
-	PB19_AF_UART5_RXD,
-	PB20_AF_UART5_CTS,
-	PB21_AF_UART5_RTS,
-	/* UART5 */
-	PB10_AF_UART6_TXD,
-	PB12_AF_UART6_CTS,
-	PB11_AF_UART6_RXD,
-	PB13_AF_UART6_RTS,
 	/* FEC */
 	PD0_AIN_FEC_TXD0,
 	PD1_AIN_FEC_TXD1,
@@ -261,12 +246,6 @@ static struct imxuart_platform_data uart_pdata[] = {
 		.flags = IMXUART_HAVE_RTSCTS,
 	}, {
 		.flags = IMXUART_HAVE_RTSCTS,
-	}, {
-		.flags = IMXUART_HAVE_RTSCTS,
-	}, {
-		.flags = IMXUART_HAVE_RTSCTS,
-	}, {
-		.flags = IMXUART_HAVE_RTSCTS,
 	},
 };
 
@@ -278,9 +257,6 @@ static void __init mxt_td60_board_init(void)
 	mxc_register_device(&mxc_uart_device0, &uart_pdata[0]);
 	mxc_register_device(&mxc_uart_device1, &uart_pdata[1]);
 	mxc_register_device(&mxc_uart_device2, &uart_pdata[2]);
-	mxc_register_device(&mxc_uart_device3, &uart_pdata[3]);
-	mxc_register_device(&mxc_uart_device4, &uart_pdata[4]);
-	mxc_register_device(&mxc_uart_device5, &uart_pdata[5]);
 	mxc_register_device(&mxc_nand_device, &mxt_td60_nand_board_info);
 
 	i2c_register_board_info(0, mxt_td60_i2c_devices,
-- 
1.6.0.4
