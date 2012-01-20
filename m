From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 21 Jan 2012 00:34:07 +0100
Subject: inconvenience when hand editing DEBUG_LL in .config
In-Reply-To: <20120120192750.GE11845@n2100.arm.linux.org.uk>
References: <20120120164036.GO4066@pengutronix.de>
 <20120120192750.GE11845@n2100.arm.linux.org.uk>
Message-ID: <20120120233407.GQ4066@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 07:27:50PM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 20, 2012 at 05:40:36PM +0100, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > usually when I want to change a single kernel option I just open .config
> > in my editor, remove the line for the config item I want to change and
> > run oldconfig. For DEBUG_LL (defined in arch/arm/Kconfig.debug) this
> > doesn't work as usual though.
> > 
> > On 3.3-rc1 the following happens:
> > 
> > 	make ARCH=arm at91rm9200_defconfig
> > 	sed -i /CONFIG_DEBUG_LL/d .config
> 
> Note that this deletes two entries.  Use /CONFIG_DEBUG_LL\\\>/d to delete
> just one (or get rid of two of those \ and use ' to quote it.)
After at91rm9200_defconfig CONFIG_DEBUG_LL is not set, so
CONFIG_DEBUG_LL_UART_NONE and the other options from that choice don't
appear in .config and so for me only a single line is removed. But
that's only an uninteresting detail.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
