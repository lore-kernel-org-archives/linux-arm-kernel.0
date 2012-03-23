From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Mar 2012 17:38:05 +0000
Subject: [PATCH 7/9] omap2plus: ensure that one of omap2/3/4 is selected
In-Reply-To: <20120323172845.GC9859@atomide.com>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
 <1332522836-29517-8-git-send-email-mathieu.poirier@linaro.org>
 <20120323172845.GC9859@atomide.com>
Message-ID: <201203231738.05742.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 March 2012, Tony Lindgren wrote:
> >  
> > +config ARCH_OMAP2_AUTO
> > +     bool
> > +     depends on !ARCH_OMAP3 && !ARCH_OMAP4
> > +     select ARCH_OMAP2
> > +     default y
> > +     help
> > +       At least one of OMAP2/OMAP3/OMAP4 needs to be enabled, this
> > +       selects OMAP2 if nothing else gets selected, to avoid non-building
> > +       configurations.
> > +
> >  comment "OMAP Core Type"
> >       depends on ARCH_OMAP2
> 
> Hmm yeah omap2 makes the smallest build, so randconfig builds
> faster than it would for omap3 or 4.
> 
> But isn't there now still a chance that randconfig does not
> select ARCH_OMAP2_AUTO either?

No. ARCH_OMAP2_AUTO is only disabled if one of OMAP3 or OMAP4
are enabled.

	Arnd
