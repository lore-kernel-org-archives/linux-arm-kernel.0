From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Oct 2011 11:15:17 +0200
Subject: [PATCH 28/30] ARM: omap: select CPU_FREQ_TABLE where needed
In-Reply-To: <4E894A95.5030107@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-29-git-send-email-arnd@arndb.de>
	<4E894A95.5030107@ti.com>
Message-ID: <5173921.eT2vCfT35d@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 October 2011 11:09:33 Santosh Shilimkar wrote:
> > diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> > index bb8f4a6..f7ef9f4 100644
> > --- a/arch/arm/plat-omap/Kconfig
> > +++ b/arch/arm/plat-omap/Kconfig
> > @@ -217,6 +217,11 @@ config OMAP_PM_NOOP
> >  
> >  endchoice
> >  
> > +config OMAP_CPU_FREQ
> > +     def_bool "y"
> > +     depends on CPU_FREQ
> > +     select CPU_FREQ_TABLE
> > +
> >  endmenu
> With CPUFREQ series from Kevin [1], I don't think we need this any-more.

I guess if it's needed, it should at least be moved to the new cpufreq
location.

> More so, I didn't find OMAP_CPU_FREQ is being used anywhere on mainline.

Yes, OMAP_CPU_FREQ is a symbol that is intentionally unused, with the
only purpose of selecting CPU_FREQ_TABLE if any omap platform together
with CPU_FREQ is enabled.

Let's drop this patch for now, if it is still needed as I think, I can
do a patch during the 3.2 cycle for the right location.

	Arnd
