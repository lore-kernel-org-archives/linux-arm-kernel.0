From: daniel@totalueberwachung.de (Daniel Willmann)
Date: Sun, 20 Apr 2014 12:56:03 +0200
Subject: [PATCH v2 1/9] ARM: centralize common multi-platform kconfig
 options
In-Reply-To: <201402282133.57910.arnd@arndb.de>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <201402282115.55948.arnd@arndb.de> <7h38j3t2ba.fsf@paris.lan>
 <201402282133.57910.arnd@arndb.de>
Message-ID: <20140420105603.GA7644@adrastea.totalueberwachung.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-02-28 at 21:33, Arnd Bergmann wrote:
> On Friday 28 February 2014, Kevin Hilman wrote:
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index 7d1588e..cf35d18 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -304,6 +304,7 @@ config ARCH_MULTIPLATFORM
> > >       bool "Allow multiple platforms to be selected"
> > >       select ARCH_WANT_OPTIONAL_GPIOLIB
> > >       select AUTO_ZRELADDR
> > > +     select CLKSRC_OF
> > >       select COMMON_CLK
> > >       select GENERIC_CLOCKEVENTS
> > >       select MULTI_IRQ_HANDLER
> > 
> > Yup, that's it.  With that, sunxi_defconfig is booting again.
> > 
> > Tested-by: Kevin Hilman <khilman@linaro.org>
> 
> I've added this patch on the *for-next* branch for now, while we
> still decide whether it is the correct solution. The alternative
> would be to only select it from the clocksource drivers that want

I see the same lockup with v3.15-rc1 on an imx233 board (olinuxino nano)
and this patch also fixes the issues I see.

Tested-by: Daniel Willmann <daniel@totalueberwachung.de>

Regards,
Daniel Willmann
