From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jan 2014 10:43:37 +0100
Subject: [PATCH] ARM: S3C[24|64]xx: move includes back under <mach/> scope
In-Reply-To: <CAHbNUh29qGSt-isqOAdVVO3x0w2mDTVnKeH+Sc_rkfkOiXc_mA@mail.gmail.com>
References: <1389707618-17011-1-git-send-email-linus.walleij@linaro.org>
 <CAHbNUh29qGSt-isqOAdVVO3x0w2mDTVnKeH+Sc_rkfkOiXc_mA@mail.gmail.com>
Message-ID: <6144980.CZru2D3yJB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 January 2014 14:41:01 Tushar Behera wrote:
> > diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
> > index c4efa1c2a5d1..a9f7a37c4173 100644
> > --- a/arch/arm/plat-samsung/pm-gpio.c
> > +++ b/arch/arm/plat-samsung/pm-gpio.c
> > @@ -19,12 +19,7 @@
> >  #include <linux/io.h>
> >  #include <linux/gpio.h>
> >
> > -#ifdef CONFIG_ARCH_S3C24XX
> > -#include <linux/platform_data/gpio-samsung-s3c24xx.h>
> > -#endif
> > -#ifdef CONFIG_ARCH_S3C64XX
> > -#include <linux/platform_data/gpio-samsung-s3c64xx.h>
> > -#endif
> > +#include <mach/gpio-samsung.h>
> 
> This inclusion should be protected by a check for CONFIG_ARCH_S3C24XX
> || CONFIG_ARCH_S3C64XX. Currently generating build errors for
> s5p64x0_defconfig, s5pc100_defconfig and s5pv210_defconfig on
> next-20140115.
> 

I noticed the same problem, but I think a better solution would
be to do the same change for s5p that Linus has done for s3c,
which is to move the nonstandard contents of mach/gpio.h to
mach/gpio-samsung.h.

	Arnd
