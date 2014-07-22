From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jul 2014 20:33:44 +0200
Subject: [PATCH v2] iio: exynos-adc: add experimental touchscreen support
In-Reply-To: <20140722180904.GB5489@core.coreip.homeip.net>
References: <5068889.1KfVx3ksNo@wuerfel>
 <20140722180904.GB5489@core.coreip.homeip.net>
Message-ID: <5072247.HRN2kuegE2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 July 2014 11:09:04 Dmitry Torokhov wrote:
> > @@ -565,6 +722,15 @@ static int exynos_adc_probe(struct platform_device *pdev)
> >       if (info->data->init_hw)
> >               info->data->init_hw(info);
> >  
> > +     /* leave out any TS related code if unreachable */
> > +     if (IS_BUILTIN(CONFIG_INPUT) ||
> > +         (IS_MODULE(CONFIG_INPUT) && config_enabled(MODULE)))
> 
> This is ugly... We need IS_SUBSYSTEM_AVAILABLE() wrapper for this...
> 
> Anyway,
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> 

I actually have a patch to introduce IS_REACHABLE() for this purpose,
but I haven't sent it out for review yet. The main user of this would
be drivers/media, which had the correct logic earlier until someone
tried to "simplify" it by replacing it all with IS_ENABLED()...

	Arnd
