From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Jun 2013 21:21:58 +0200
Subject: [PATCH] cpuidle: fix ARCH_NEEDS_CPU_IDLE_COUPLED dependency
 warning
In-Reply-To: <51B21D65.3040604@ti.com>
References: <1370626856-2876-1-git-send-email-daniel.lezcano@linaro.org>
 <51B21D65.3040604@ti.com>
Message-ID: <201306072121.58719.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013, Santosh Shilimkar wrote:
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index f49cd51..831e89e 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -83,7 +83,7 @@ config ARCH_OMAP4
> >       depends on ARCH_OMAP2PLUS
> >       depends on ARCH_MULTI_V7
> >       select ARCH_HAS_OPP
> > -     select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
> > +     select ARCH_NEEDS_CPU_IDLE_COUPLED if (SMP && CPU_IDLE)
>
> I remember Colin mentioning about above dependency is taken care
> already in design [1]

It's a matter of how it gets represented in Kconfig. Right now 
the ARCH_NEEDS_CPU_IDLE_COUPLED symbol has a dependency on CPU_IDLE,
so we cannot select it if CPU_IDLE is not set (or get a build time
warning).

I originally suggested removing the dependency, but Daniel preferred
to leave it there as an explicit dependency so it is required to
do this change instead.

	Arnd
