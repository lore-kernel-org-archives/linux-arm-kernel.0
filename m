From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 Dec 2010 21:31:48 +0100
Subject: [PATCH v3 03/15] ARM: mxs: Add reset routines
In-Reply-To: <19711.13516.842225.349704@ipc1.ka-ro>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-2-git-send-email-shawn.guo@freescale.com>
	<19711.13516.842225.349704@ipc1.ka-ro>
Message-ID: <20101208203148.GE17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On Wed, Dec 08, 2010 at 08:33:32AM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Shawn Guo writes:
> >  - The mxs wdog is implemented in RTC block.
> >  - There is a generic software reset routine for most modules on mxs.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> > Changes for v3:
> >  - Change wdog timeout to 10ms for safety
> >  - Simplify function mxs_reset_block() to get it look better
> > 
> > Changes for v2:
> >  - Move rtc clock enabling from arch_reset() into mxs_arch_reset_init()
> > 
> mxs_arch_reset_init() is currently being called from the .map_io hook
> in mach-mxs/mm-mx23.c and mm-mx28.c which is called before clocks are
> registered.
> But IMO this should be removed from the .map_io hook anyway (as well
> as mxs_iomux_init()).
I assume you want to make this an initcall?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
