From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jun 2014 21:53:40 +0100
Subject: [PATCH] ARM: mvebu: rename ARM_ERRATA_753970
In-Reply-To: <20140620202100.GG21711@titan.lakedaemon.net>
References: <201404052101.19381.arnd@arndb.de>
 <201404052104.11363.arnd@arndb.de> <1396777049.30640.9.camel@x220>
 <53418889.2050002@free-electrons.com> <1396805315.7723.8.camel@x220>
 <1401094871.25902.20.camel@x220>
 <20140620202100.GG21711@titan.lakedaemon.net>
Message-ID: <20140620205340.GX32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 04:21:00PM -0400, Jason Cooper wrote:
> It looks like rmk just added a patch to fixing the selection of the
> erratas.  Could you please take a look and either rebase or drop this
> patch?

Yes please.  If it's needed, just update it to be:

> > diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> > index 3f73eecbcfb0..501d0f42e7b2 100644
> > --- a/arch/arm/mach-mvebu/Kconfig
> > +++ b/arch/arm/mach-mvebu/Kconfig
> > @@ -35,7 +35,7 @@ config MACH_ARMADA_370
> >  config MACH_ARMADA_375
> >  	bool "Marvell Armada 375 boards" if ARCH_MULTI_V7
> >  	select ARM_ERRATA_720789
> > -	select ARM_ERRATA_753970
> > +	select PL310_ERRATA_753970 if CACHE_PL310

	select PL310_ERRATA_753970 if CACHE_L2X0

for both platforms.  Although there's no harm in using CACHE_PL310 at
the moment, my longer term plan is to eventually kill CACHE_PL310 as
it's entirely redundant for ARM versions of the L2 cache (it's only
used by the old L2x0 code which I've been unable to eliminate entirely.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
