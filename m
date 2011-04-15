From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 15 Apr 2011 22:22:13 +0200
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <20110415201925.GK4423@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<20110415201107.GO31990@pengutronix.de>
	<20110415201925.GK4423@n2100.arm.linux.org.uk>
Message-ID: <20110415202213.GP31990@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 09:19:25PM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 15, 2011 at 10:11:07PM +0200, Uwe Kleine-K?nig wrote:
> > On Fri, Apr 15, 2011 at 02:06:07PM +0100, Russell King - ARM Linux wrote:
> > > This is work in progress.
> > > 
> > > We have two SoCs using SRAM, both with their own allocation systems,
> > > and both with their own ways of copying functions into the SRAM.
> > I havn't checked the details, but maybe the code in
> > arch/arm/plat-mxc/iram_alloc.c could be migrated to your approach, too?
> 
> Its already in there now that I have replies from Nguyen Dinh.  It
> looks like this presently:
> 
>  arch/arm/plat-mxc/Kconfig                   |    2 +-
>  arch/arm/plat-mxc/include/mach/iram.h       |   24 +++++++--
>  arch/arm/plat-mxc/iram_alloc.c              |   50 +++++---------------
> 
> and if we get rid of the iram_alloc/iram_free wrappers around the
> sram_pool (now pv_pool) alloc/free in iram.h, in the same way I've
> done for Davinci, then we get less new additions too.
Great!

Thanks,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
