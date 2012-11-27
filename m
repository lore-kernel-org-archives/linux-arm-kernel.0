From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 27 Nov 2012 07:50:59 -0500
Subject: [PATCH v3 2/4] ARM: kirkwood: DT board setup for Network Space
 v2 and parents
In-Reply-To: <20121127111454.GG8628@kw.sim.vm.gnt>
References: <1350468546-25901-1-git-send-email-simon.guinot@sequanux.org>
 <1350468546-25901-3-git-send-email-simon.guinot@sequanux.org>
 <20121126090253.GI9580@quad.lixom.net>
 <20121126151811.GF8628@kw.sim.vm.gnt>
 <20121126160449.GD15800@titan.lakedaemon.net>
 <20121127111454.GG8628@kw.sim.vm.gnt>
Message-ID: <20121127125059.GH15800@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 12:14:55PM +0100, Simon Guinot wrote:
> On Mon, Nov 26, 2012 at 11:04:49AM -0500, Jason Cooper wrote:
> > On Mon, Nov 26, 2012 at 04:18:11PM +0100, Simon Guinot wrote:
> > > On Mon, Nov 26, 2012 at 01:02:53AM -0800, Olof Johansson wrote:
> > > > Hi,
> > > > 
> > > > This is more directed at Jason and the other maintainers than you, Simon --
> > > > it's something I noticed when looking at his pull request.
> > > > 
> > > > On Wed, Oct 17, 2012 at 12:09:04PM +0200, Simon Guinot wrote:
> > > > 
> > > > > diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> > > > > index 50bca50..847e0c2 100644
> > > > > --- a/arch/arm/mach-kirkwood/Kconfig
> > > > > +++ b/arch/arm/mach-kirkwood/Kconfig
> > > > > @@ -130,6 +130,27 @@ config MACH_KM_KIRKWOOD_DT
> > > > >  	  Say 'Y' here if you want your kernel to support the
> > > > >  	  Keymile Kirkwood Reference Desgin, using Flattened Device Tree.
> > > > >  
> > > > > +config MACH_INETSPACE_V2_DT
> > > > > +	bool "LaCie Internet Space v2 NAS (Flattened Device Tree)"
> > > > > +	select ARCH_KIRKWOOD_DT
> > > > > +	help
> > > > > +	  Say 'Y' here if you want your kernel to support the LaCie
> > > > > +	  Internet Space v2 NAS, using Flattened Device Tree.
> > > > > +
> > > > > +config MACH_NETSPACE_V2_DT
> > > > > +	bool "LaCie Network Space v2 NAS (Flattened Device Tree)"
> > > > > +	select ARCH_KIRKWOOD_DT
> > > > > +	help
> > > > > +	  Say 'Y' here if you want your kernel to support the LaCie
> > > > > +	  Network Space v2 NAS, using Flattened Device Tree.
> > > > > +
> > > > > +config MACH_NETSPACE_MAX_V2_DT
> > > > > +	bool "LaCie Network Space Max v2 NAS (Flattened Device Tree)"
> > > > > +	select ARCH_KIRKWOOD_DT
> > > > > +	help
> > > > > +	  Say 'Y' here if you want your kernel to support the LaCie
> > > > > +	  Network Space Max v2 NAS, using Flattened Device Tree.
> > > > 
> > > > It would be nice to get away from these config options. The whole point with
> > > > device tree is to no longer have to do code changes for new similar boards.
> > > > 
> > > > And even then, since they share the same init function, there's no need for
> > > > three options, just one.
> > > > 
> > > > > diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> > > > > index 294779f..1f63d80 100644
> > > > > --- a/arch/arm/mach-kirkwood/Makefile
> > > > > +++ b/arch/arm/mach-kirkwood/Makefile
> > > > > @@ -31,3 +31,6 @@ obj-$(CONFIG_MACH_GOFLEXNET_DT)		+= board-goflexnet.o
> > > > >  obj-$(CONFIG_MACH_LSXL_DT)		+= board-lsxl.o
> > > > >  obj-$(CONFIG_MACH_IOMEGA_IX2_200_DT)	+= board-iomega_ix2_200.o
> > > > >  obj-$(CONFIG_MACH_KM_KIRKWOOD_DT)	+= board-km_kirkwood.o
> > > > > +obj-$(CONFIG_MACH_INETSPACE_V2_DT)	+= board-ns2.o
> > > > > +obj-$(CONFIG_MACH_NETSPACE_V2_DT)	+= board-ns2.o
> > > > > +obj-$(CONFIG_MACH_NETSPACE_MAX_V2_DT)	+= board-ns2.o
> > > > 
> > > > Same here.
> > > 
> > > Hi,
> > > 
> > > All this configuration options (plus those for ns2 lite and mini) are
> > > indeed useless as we are using a single init function. Moreover there
> > > is no code relying on this options in the file  board-ns2.c. All the
> > > checks are made at run-time.
> > > 
> > > I will send a patch to remove this options.
> > 
> > No need to jump on it just yet.  Nothing more is going into 3.8.  We
> > plan on cleaning up a lot of this as the first part of stuff for 3.9.
> > It'll be easier to have one series knocking it all out as opposed to
> > several board-specific patches from individuals.
> 
> About the config duplicate options, I think that the ns2 is the only
> problem. But if you plan to remove the board-*.c files for 3.9, maybe
> there is no need at all to fix the issue ?

Correct.  I think we might have one or two outliers when we're done, but
board-dt.c should just compat with marvell,kirkwood.

> > Unless, of course, you're volunteering to do the whole cleanup.  Then by
> > all means, don't let me stand in your way.  :-)
> 
> The whole cleanup, I don't know :) But for sure, I can help. For
> example, I could do the gpio-poweroff migration.

That would be much appreciated.  Thanks!

Jason.
