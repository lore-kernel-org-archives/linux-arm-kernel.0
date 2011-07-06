From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 05 Jul 2011 21:37:33 -0400 (EDT)
Subject: [PATCH] ARM: mach-s3c24a0: delete
In-Reply-To: <alpine.LFD.2.00.1107051357480.14596@xanadu.home>
References: <alpine.LFD.2.00.1106281613380.2142@xanadu.home>
	<20110628211712.GF21138@trinity.fluff.org>
	<201106282322.57631.arnd@arndb.de>
	<20110628212749.GJ21138@trinity.fluff.org>
	<alpine.LFD.2.00.1107051357480.14596@xanadu.home>
Message-ID: <alpine.LFD.2.00.1107051721080.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Jul 2011, Nicolas Pitre wrote:

> On Tue, 28 Jun 2011, Ben Dooks wrote:
> 
> > On Tue, Jun 28, 2011 at 11:22:57PM +0200, Arnd Bergmann wrote:
> > 
> > > On a related note, what about mach-s3c2400? It seems to be even more
> > > incomplete.
> > 
> > Probably the same fate awaits that. It is so old that there's little
> > incentive to do anything with it.
> 
> Here it is.  Please ACK.
> 
> commit 896ce6bc5bf1e0f963186ab0db4e692ecebeb14c
> Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date:   Tue Jul 5 13:55:21 2011 -0400
> 
>     ARM: mach-s3c2400: delete

And here's some more I'm folding into that patch:

diff --git a/Documentation/arm/Samsung-S3C24XX/Overview.txt b/Documentation/arm/Samsung-S3C24XX/Overview.txt
index c12bfc1..359587b 100644
--- a/Documentation/arm/Samsung-S3C24XX/Overview.txt
+++ b/Documentation/arm/Samsung-S3C24XX/Overview.txt
@@ -8,10 +8,13 @@ Introduction
 
   The Samsung S3C24XX range of ARM9 System-on-Chip CPUs are supported
   by the 's3c2410' architecture of ARM Linux. Currently the S3C2410,
-  S3C2412, S3C2413, S3C2416 S3C2440, S3C2442, S3C2443 and S3C2450 devices
+  S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443 and S3C2450 devices
   are supported.
 
-  Support for the S3C2400 and S3C24A0 series are in progress.
+  Support for the S3C2400 and S3C24A0 series was never completed and the
+  corresponding code has been removed after a while.  If someone wishes to
+  revive this effort, partial support can be retrieved from earlier Linux
+  versions.
 
   The S3C2416 and S3C2450 devices are very similar and S3C2450 support is
   included under the arch/arm/mach-s3c2416 directory. Note, whilst core
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 25f34a8..206c34e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -171,7 +171,7 @@ machine-$(CONFIG_ARCH_PNX4008)		:= pnx4008
 machine-$(CONFIG_ARCH_PXA)		:= pxa
 machine-$(CONFIG_ARCH_REALVIEW)		:= realview
 machine-$(CONFIG_ARCH_RPC)		:= rpc
-machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2400 s3c2412 s3c2416 s3c2440 s3c2443
+machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2412 s3c2416 s3c2440 s3c2443
 machine-$(CONFIG_ARCH_S3C64XX)		:= s3c64xx
 machine-$(CONFIG_ARCH_S5P64X0)		:= s5p64x0
 machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-mem.h b/arch/arm/mach-s3c2410/include/mach/regs-mem.h
index 988a686..e0c67b0 100644
--- a/arch/arm/mach-s3c2410/include/mach/regs-mem.h
+++ b/arch/arm/mach-s3c2410/include/mach/regs-mem.h
@@ -145,29 +145,8 @@
 #define S3C2410_BANKCON_Tacs_SHIFT	(13)
 
 #define S3C2410_BANKCON_SRAM		(0x0 << 15)
-#define S3C2400_BANKCON_EDODRAM		(0x2 << 15)
 #define S3C2410_BANKCON_SDRAM		(0x3 << 15)
 
-/* next bits only for EDO DRAM in 6,7 */
-#define S3C2400_BANKCON_EDO_Trcd1      (0x00 << 4)
-#define S3C2400_BANKCON_EDO_Trcd2      (0x01 << 4)
-#define S3C2400_BANKCON_EDO_Trcd3      (0x02 << 4)
-#define S3C2400_BANKCON_EDO_Trcd4      (0x03 << 4)
-
-/* CAS pulse width */
-#define S3C2400_BANKCON_EDO_PULSE1     (0x00 << 3)
-#define S3C2400_BANKCON_EDO_PULSE2     (0x01 << 3)
-
-/* CAS pre-charge */
-#define S3C2400_BANKCON_EDO_TCP1       (0x00 << 2)
-#define S3C2400_BANKCON_EDO_TCP2       (0x01 << 2)
-
-/* control column address select */
-#define S3C2400_BANKCON_EDO_SCANb8     (0x00 << 0)
-#define S3C2400_BANKCON_EDO_SCANb9     (0x01 << 0)
-#define S3C2400_BANKCON_EDO_SCANb10    (0x02 << 0)
-#define S3C2400_BANKCON_EDO_SCANb11    (0x03 << 0)
-
 /* next bits only for SDRAM in 6,7 */
 #define S3C2410_BANKCON_Trcd2		(0x00 << 2)
 #define S3C2410_BANKCON_Trcd3		(0x01 << 2)
@@ -194,12 +173,6 @@
 #define S3C2410_REFRESH_TRP_3clk	(1<<20)
 #define S3C2410_REFRESH_TRP_4clk	(2<<20)
 
-#define S3C2400_REFRESH_DRAM_TRP_MASK   (3<<20)
-#define S3C2400_REFRESH_DRAM_TRP_1_5clk (0<<20)
-#define S3C2400_REFRESH_DRAM_TRP_2_5clk (1<<20)
-#define S3C2400_REFRESH_DRAM_TRP_3_5clk (2<<20)
-#define S3C2400_REFRESH_DRAM_TRP_4_5clk (3<<20)
-
 #define S3C2410_REFRESH_TSRC_MASK	(3<<18)
 #define S3C2410_REFRESH_TSRC_4clk	(0<<18)
 #define S3C2410_REFRESH_TSRC_5clk	(1<<18)
@@ -222,7 +195,6 @@
 #define S3C2410_BANKSIZE_4M		(0x5 << 0)
 #define S3C2410_BANKSIZE_2M		(0x4 << 0)
 #define S3C2410_BANKSIZE_MASK		(0x7 << 0)
-#define S3C2400_BANKSIZE_MASK           (0x4 << 0)
 #define S3C2410_BANKSIZE_SCLK_EN	(1<<4)
 #define S3C2410_BANKSIZE_SCKE_EN	(1<<5)
 #define S3C2410_BANKSIZE_BURST		(1<<7)
diff --git a/arch/arm/plat-s3c24xx/include/plat/regs-spi.h b/arch/arm/plat-s3c24xx/include/plat/regs-spi.h
index 2b35479..892e2f6 100644
--- a/arch/arm/plat-s3c24xx/include/plat/regs-spi.h
+++ b/arch/arm/plat-s3c24xx/include/plat/regs-spi.h
@@ -67,7 +67,6 @@
 
 #define S3C2410_SPPIN_ENMUL	  (1<<2)	/* Multi Master Error detect */
 #define S3C2410_SPPIN_RESERVED	  (1<<1)
-#define S3C2400_SPPIN_nCS     	  (1<<1)	/* SPI Card Select */
 #define S3C2410_SPPIN_KEEP	  (1<<0)	/* Master Out keep */
 
 #define S3C2410_SPPRE	 (0x0C)
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 636144c..b056908 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -457,7 +457,6 @@ config SERIAL_SAMSUNG_UARTS_4
 config SERIAL_SAMSUNG_UARTS
 	int
 	depends on ARM && PLAT_SAMSUNG
-	default 2 if ARCH_S3C2400
 	default 6 if ARCH_S5P6450
 	default 4 if SERIAL_SAMSUNG_UARTS_4
 	default 3
@@ -489,13 +488,6 @@ config SERIAL_SAMSUNG_CONSOLE
 	  your boot loader about how to pass options to the kernel at
 	  boot time.)
 
-config SERIAL_S3C2400
-	tristate "Samsung S3C2410 Serial port support"
-	depends on ARM && SERIAL_SAMSUNG && CPU_S3C2400
-	default y if CPU_S3C2400
-	help
-	  Serial port support for the Samsung S3C2400 SoC
-
 config SERIAL_S3C2410
 	tristate "Samsung S3C2410 Serial port support"
 	depends on SERIAL_SAMSUNG && CPU_S3C2410
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index cb2628f..7588d87 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -38,7 +38,6 @@ obj-$(CONFIG_SERIAL_BCM63XX) += bcm63xx_uart.o
 obj-$(CONFIG_SERIAL_BFIN) += bfin_5xx.o
 obj-$(CONFIG_SERIAL_BFIN_SPORT) += bfin_sport_uart.o
 obj-$(CONFIG_SERIAL_SAMSUNG) += samsung.o
-obj-$(CONFIG_SERIAL_S3C2400) += s3c2400.o
 obj-$(CONFIG_SERIAL_S3C2410) += s3c2410.o
 obj-$(CONFIG_SERIAL_S3C2412) += s3c2412.o
 obj-$(CONFIG_SERIAL_S3C2440) += s3c2440.o
diff --git a/drivers/tty/serial/s3c2400.c b/drivers/tty/serial/s3c2400.c
deleted file mode 100644
index d13051b..0000000
--- a/drivers/tty/serial/s3c2400.c
+++ /dev/null
@@ -1,105 +0,0 @@
-/*
- * Driver for Samsung SoC onboard UARTs.
- *
- * Ben Dooks, Copyright (c) 2003-2005 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/module.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-
-#include <asm/irq.h>
-
-#include <mach/hardware.h>
-
-#include <plat/regs-serial.h>
-#include <mach/regs-gpio.h>
-
-#include "samsung.h"
-
-static int s3c2400_serial_getsource(struct uart_port *port,
-				    struct s3c24xx_uart_clksrc *clk)
-{
-	clk->divisor = 1;
-	clk->name = "pclk";
-
-	return 0;
-}
-
-static int s3c2400_serial_setsource(struct uart_port *port,
-				    struct s3c24xx_uart_clksrc *clk)
-{
-	return 0;
-}
-
-static int s3c2400_serial_resetport(struct uart_port *port,
-				    struct s3c2410_uartcfg *cfg)
-{
-	dbg("s3c2400_serial_resetport: port=%p (%08lx), cfg=%p\n",
-	    port, port->mapbase, cfg);
-
-	wr_regl(port, S3C2410_UCON,  cfg->ucon);
-	wr_regl(port, S3C2410_ULCON, cfg->ulcon);
-
-	/* reset both fifos */
-
-	wr_regl(port, S3C2410_UFCON, cfg->ufcon | S3C2410_UFCON_RESETBOTH);
-	wr_regl(port, S3C2410_UFCON, cfg->ufcon);
-
-	return 0;
-}
-
-static struct s3c24xx_uart_info s3c2400_uart_inf = {
-	.name		= "Samsung S3C2400 UART",
-	.type		= PORT_S3C2400,
-	.fifosize	= 16,
-	.rx_fifomask	= S3C2410_UFSTAT_RXMASK,
-	.rx_fifoshift	= S3C2410_UFSTAT_RXSHIFT,
-	.rx_fifofull	= S3C2410_UFSTAT_RXFULL,
-	.tx_fifofull	= S3C2410_UFSTAT_TXFULL,
-	.tx_fifomask	= S3C2410_UFSTAT_TXMASK,
-	.tx_fifoshift	= S3C2410_UFSTAT_TXSHIFT,
-	.get_clksrc	= s3c2400_serial_getsource,
-	.set_clksrc	= s3c2400_serial_setsource,
-	.reset_port	= s3c2400_serial_resetport,
-};
-
-static int s3c2400_serial_probe(struct platform_device *dev)
-{
-	return s3c24xx_serial_probe(dev, &s3c2400_uart_inf);
-}
-
-static struct platform_driver s3c2400_serial_driver = {
-	.probe		= s3c2400_serial_probe,
-	.remove		= __devexit_p(s3c24xx_serial_remove),
-	.driver		= {
-		.name	= "s3c2400-uart",
-		.owner	= THIS_MODULE,
-	},
-};
-
-s3c24xx_console_init(&s3c2400_serial_driver, &s3c2400_uart_inf);
-
-static inline int s3c2400_serial_init(void)
-{
-	return s3c24xx_serial_init(&s3c2400_serial_driver, &s3c2400_uart_inf);
-}
-
-static inline void s3c2400_serial_exit(void)
-{
-	platform_driver_unregister(&s3c2400_serial_driver);
-}
-
-module_init(s3c2400_serial_init);
-module_exit(s3c2400_serial_exit);
-
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
-MODULE_DESCRIPTION("Samsung S3C2400 SoC Serial port driver");
-MODULE_ALIAS("platform:s3c2400-uart");
