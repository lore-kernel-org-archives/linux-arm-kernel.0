From: pieterg@gmx.com (pieterg)
Date: Fri, 9 Jul 2010 18:47:59 +0200
Subject: [PATCH v2 5/5] colibri-pxa3xx: add touchscreen support
In-Reply-To: <201007091814.25040.arnd@arndb.de>
References: <201007082249.59852.pieterg@gmx.com>
	<201007090903.50318.pieterg@gmx.com>
	<201007091814.25040.arnd@arndb.de>
Message-ID: <201007091847.59787.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 July 2010 18:14:24 Arnd Bergmann wrote:
> On Friday 09 July 2010, pieterg wrote:
> > > > --- a/arch/arm/mach-pxa/include/mach/colibri.h
> > > > +++ b/arch/arm/mach-pxa/include/mach/colibri.h
> > > > @@ -30,6 +30,12 @@ extern void colibri_pxa3xx_init_nand(void);
> > > >  static inline void colibri_pxa3xx_init_nand(void) {}
> > > >  #endif
> > > >
> > > > +#if defined(CONFIG_INPUT_TOUCHSCREEN)
> > > > +extern void colibri_pxa3xx_init_touchscreen(void);
> > > > +#else
> > > > +static inline void colibri_pxa3xx_init_touchscreen(void) {}
> > > > +#endif
> > > > +
> > > >  /* physical memory regions */
> > > >  #define COLIBRI_SDRAM_BASE 0xa0000000      /* SDRAM region */
> > >
> > > What will happen if both of the TS devices are selected?
> >
> > That's no problem.
> > I actually have both configs enabled, so I can run the same kernel on
> > the 310 (which is using wm97 for a while now) and the 320 (which still
> > has ucb1400 at the moment)
>
> But doesn't the code still create both devices in /sys/devices/platform
> then? AFAICT, there is no runtime probing support to make sure you only
> register the device that is there.

Yes, they both show up. But at least the do not conflict, and only the 
detected device will register an input device.
