From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 11 Jul 2011 15:58:15 +0200
Subject: [PATCH 1/1] ARM: i.MX50/53: debug-macro: fix UART_PADDR
In-Reply-To: <20110711100838.GD2482@matterhorn1>
References: <1310251913-9877-1-git-send-email-troy.kisky@boundarydevices.com>
	<20110711090609.GB2482@matterhorn1>
	<20110711093055.GJ13840@pengutronix.de>
	<20110711100838.GD2482@matterhorn1>
Message-ID: <20110711135815.GC7751@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 01:08:38PM +0300, Amit Kucheria wrote:
> On 11 Jul 11, Uwe Kleine-K?nig wrote:
> > On Mon, Jul 11, 2011 at 12:06:09PM +0300, Amit Kucheria wrote:
> > > On 11 Jul 09, Troy Kisky wrote:
> > > > The i.MX51 UART_PADDR value does not work for MX50/53.
> > > > 
> > > > Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> > > 
> > > Acked-by: Amit Kucheria <amit.kucheria@canonical.com>
> > > 
> > > but I think we should switch to runtime detection of the machine (machine
> > > ID?) and then set the port address.
> > > 
> > > See arch/arm/plat-omap/include/plat/uncompress.h for a possible scheme.
> > mach/debug-macro.S and mach/uncompress.h are two different things. And
> > the uncompress stuff is dynamic for mxc AFAIK.
>  
> Indeed they're different. But it seems to me that
> arch/arm/mach-omap2/include/mach/debug-macro.S and arch/arm/plat-omap/include/plat/uncompress.h
> show clearly how we can deal with the serial port addresses (for DEBUG_LL)
> dynamically. No?
Looking at arch/arm/mach-omap2/include/mach/debug-macro.S it doesn't
look easy. And considering that debug-macro.S is only needed for early
board bringup, it's totally OK to have hardcoded values for only a
single SOC at a time in it. And I really like to keep this simple as it
is the first working debug mechanism during boot.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
