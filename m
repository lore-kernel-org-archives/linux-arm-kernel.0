From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 9 Jan 2013 11:08:40 +0000
Subject: [PATCH 2/3] ARM: ux500: Turn on the 'heartbeat' LED trigger
In-Reply-To: <20130109103510.GE3931@n2100.arm.linux.org.uk>
References: <1357725965-27342-1-git-send-email-lee.jones@linaro.org>
 <1357725965-27342-2-git-send-email-lee.jones@linaro.org>
 <201301091018.55058.arnd@arndb.de>
 <20130109103510.GE3931@n2100.arm.linux.org.uk>
Message-ID: <20130109110840.GD31678@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 09 Jan 2013, Russell King - ARM Linux wrote:

> On Wed, Jan 09, 2013 at 10:18:54AM +0000, Arnd Bergmann wrote:
> > On Wednesday 09 January 2013, Lee Jones wrote:
> > > diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
> > > index 5dea906..0f25b07 100644
> > > --- a/arch/arm/mach-ux500/Kconfig
> > > +++ b/arch/arm/mach-ux500/Kconfig
> > > @@ -43,6 +43,8 @@ config MACH_HREFV60
> > >  config MACH_SNOWBALL
> > >         bool "U8500 Snowball platform"
> > >         select MACH_MOP500
> > > +       select LEDS_TRIGGERS
> > > +       select LEDS_TRIGGER_HEARTBEAT
> > >         help
> > >           Include support for the snowball development platform.
> > 
> > Be careful with "select" statements like this when there are other
> > dependencies. I think LEDS_TRIGGERS depends on LEDS_CLASS, so this
> > should probably be written as
> > 
> > 	select LEDS_TRIGGERS if LEDS_CLASS
> 
> Umm, this is also wrong for another reason.  LEDS is an optional feature.
> It's not required for the platform to be functional.  So why the hell would
> anyone want to _force_ such an optional feature to be mandatory?
> 
> This is something that the default config published for the platform should
> be handling.

Do you mean <config_dir>/u8500_defconfig?

If so, that's wrong, as it covers many more boards than just Snowball
and this is only applicable on the Snowball board. So how else can
I enable this feature?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
