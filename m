From: tony@atomide.com (Tony Lindgren)
Date: Sat, 27 Oct 2012 09:29:33 -0700
Subject: [GIT PULL] omap plat header removal for v3.8 merge window, part1
In-Reply-To: <201210270809.02140.arnd@arndb.de>
References: <20121019023300.GN30550@atomide.com>
 <20121026175537.GL11908@atomide.com>
 <20121026223848.GY11908@atomide.com>
 <201210270809.02140.arnd@arndb.de>
Message-ID: <20121027162932.GZ11908@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [121027 01:11]:
> On Friday 26 October 2012, Tony Lindgren wrote:
> > Here's a patch for that. It's against what I have queued up in
> > omap-for-v3.8/cleanup-headers. Does that look OK to you?
> 
> Hi Tony,
> 
> thanks for the quick follow-up. Using the absolute #include statements
> again looks good, but now there is another problem:
> 
> > diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
> > index cd169c3..03b1e80 100644
> > --- a/arch/arm/mach-omap1/Makefile
> > +++ b/arch/arm/mach-omap1/Makefile
> > @@ -2,6 +2,8 @@
> >  # Makefile for the linux kernel.
> >  #
> >  
> > +ccflags-$(CONFIG_ARCH_OMAP) := -I$(srctree)/arch/arm
> > +
> 
> This is not what I meant, I don't think we want to have the entire
> arch/arm/ hierarchy visible in platform directories. Instead, I thought
> we'd keep using the existing arch/arm/mach-$foo/include/mach directories
> that are currently visible to all files and make them available only
> to platforms that explicitly add -I$(srctree)/arch/arm/include/mach-$foo/include
> to their local include path.
> 
> This of course requires moving all those headers back to where they just came
> from.

OK I'll take a look. Most of them should be local to mach-omap2,
so it may not be that bad with the file moves.

Regards,

Tony
