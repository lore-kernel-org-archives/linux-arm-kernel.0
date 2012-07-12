From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 Jul 2012 18:12:41 +0900
Subject: [PATCH] ARM: SAMSUNG: Introduce Kconfig variable for Samsung
 custom clk API
In-Reply-To: <201207050924.43932.heiko@sntech.de>
References: <1341418044-24572-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201207050924.43932.heiko@sntech.de>
Message-ID: <0fb101cd600e$7d42c970$77c85c50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Am Mittwoch, 4. Juli 2012, 18:07:24 schrieb Mark Brown:
> > Make it easier to switch to the common clock API by making the existing
> > clock API implementation depend on a Kconfig symbol which is enabled
> when
> > the common clock API is disabled. This means that we can have some SoCs
> > using the common clock API and some using the existing API rather than
> > needing a flag day to convert the entire family of devices over.
> nice idea.
> 
Yes, I think so.

> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> 
Applied.

And, I think, need to sort out the SAMSUNG_CLKSRC next time :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> 
> > ---
> >  arch/arm/plat-samsung/Kconfig  |    4 ++++
> >  arch/arm/plat-samsung/Makefile |    4 ++--
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-
> samsung/Kconfig
> > index ffc84ac..7aca31c 100644
> > --- a/arch/arm/plat-samsung/Kconfig
> > +++ b/arch/arm/plat-samsung/Kconfig
> > @@ -78,6 +78,10 @@ config S5P_HRT
> >
> >  # clock options
> >
> > +config SAMSUNG_CLOCK
> > +	bool
> > +	default y if !COMMON_CLK
> > +
> >  config SAMSUNG_CLKSRC
> >  	bool
> >  	help
> > diff --git a/arch/arm/plat-samsung/Makefile
> > b/arch/arm/plat-samsung/Makefile index 856f4ee..9e40e8d 100644
> > --- a/arch/arm/plat-samsung/Makefile
> > +++ b/arch/arm/plat-samsung/Makefile
> > @@ -15,8 +15,8 @@ obj-y				+= init.o cpu.o
> >  obj-$(CONFIG_ARCH_USES_GETTIMEOFFSET)   += time.o
> >  obj-$(CONFIG_S5P_HRT) 		+= s5p-time.o
> >
> > -obj-y				+= clock.o
> > -obj-y				+= pwm-clock.o
> > +obj-$(CONFIG_SAMSUNG_CLOCK)	+= clock.o
> > +obj-$(CONFIG_SAMSUNG_CLOCK)	+= pwm-clock.o
> >
> >  obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
> >  obj-$(CONFIG_S5P_CLOCK)		+= s5p-clock.o
