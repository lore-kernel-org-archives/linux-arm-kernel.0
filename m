From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 20 Jan 2012 17:40:36 +0100
Subject: inconvenience when hand editing DEBUG_LL in .config
Message-ID: <20120120164036.GO4066@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

usually when I want to change a single kernel option I just open .config
in my editor, remove the line for the config item I want to change and
run oldconfig. For DEBUG_LL (defined in arch/arm/Kconfig.debug) this
doesn't work as usual though.

On 3.3-rc1 the following happens:

	make ARCH=arm at91rm9200_defconfig
	sed -i /CONFIG_DEBUG_LL/d .config
	make ARCH=arm oldconfig

The last command then asks me for DEBUG_LL, after specifying 'y', the
output looks as follows:

	Verbose user fault messages (DEBUG_USER) [N/y/?] n
	Kernel low-level debugging functions (read help!) (DEBUG_LL) [N/y/?] (NEW) y
	  Kernel low-level debugging port
	  > 1. No low-level debugging UART (DEBUG_LL_UART_NONE) (NEW)
	    2. Kernel low-level debugging via EmbeddedICE DCC channel (DEBUG_ICEDCC) (NEW)
	    3. Kernel low-level debugging on rm9200, 9260/9g20, 9261/9g10 and 9rl (AT91_DEBUG_LL_DBGU0) (NEW)
	  choice[1-3]: 1
	  Early printk (EARLY_PRINTK) [N/y/?] (NEW) 

Note that I didn't specify the '1' for the choice even though all items
are marked as new and oldconfig only starts at EARLY_PRINTK to ask
again.

I would have expected to be able to select AT91_DEBUG_LL_DBGU0.

This is not intended, is it?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
