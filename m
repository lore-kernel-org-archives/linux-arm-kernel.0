From: stigge@antcom.de (Roland Stigge)
Date: Sat, 25 Feb 2012 16:35:18 +0100
Subject: [PATCH v2 6/6] ARM: LPC32xx: serial.c: Fixed loop limit
In-Reply-To: <1330184118-10270-1-git-send-email-stigge@antcom.de>
References: <1330184118-10270-1-git-send-email-stigge@antcom.de>
Message-ID: <1330184118-10270-7-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a wrong loop limit on UART init.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 arch/arm/mach-lpc32xx/serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/serial.c
+++ linux-2.6/arch/arm/mach-lpc32xx/serial.c
@@ -187,7 +187,7 @@ void __init lpc32xx_serial_init(void)
 
 	/* This needs to be done after all UART clocks are setup */
 	__raw_writel(clkmodes, LPC32XX_UARTCTL_CLKMODE);
-	for (i = 0; i < ARRAY_SIZE(uartinit_data) - 1; i++) {
+	for (i = 0; i < ARRAY_SIZE(uartinit_data); i++) {
 		/* Force a flush of the RX FIFOs to work around a HW bug */
 		puart = serial_std_platform_data[i].mapbase;
 		__raw_writel(0xC1, LPC32XX_UART_IIR_FCR(puart));
