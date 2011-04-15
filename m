From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Apr 2011 21:19:25 +0100
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <20110415201107.GO31990@pengutronix.de>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<20110415201107.GO31990@pengutronix.de>
Message-ID: <20110415201925.GK4423@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 10:11:07PM +0200, Uwe Kleine-K?nig wrote:
> On Fri, Apr 15, 2011 at 02:06:07PM +0100, Russell King - ARM Linux wrote:
> > This is work in progress.
> > 
> > We have two SoCs using SRAM, both with their own allocation systems,
> > and both with their own ways of copying functions into the SRAM.
> I havn't checked the details, but maybe the code in
> arch/arm/plat-mxc/iram_alloc.c could be migrated to your approach, too?

Its already in there now that I have replies from Nguyen Dinh.  It
looks like this presently:

 arch/arm/plat-mxc/Kconfig                   |    2 +-
 arch/arm/plat-mxc/include/mach/iram.h       |   24 +++++++--
 arch/arm/plat-mxc/iram_alloc.c              |   50 +++++---------------

and if we get rid of the iram_alloc/iram_free wrappers around the
sram_pool (now pv_pool) alloc/free in iram.h, in the same way I've
done for Davinci, then we get less new additions too.
