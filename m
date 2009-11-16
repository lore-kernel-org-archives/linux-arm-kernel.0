From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 16 Nov 2009 09:14:25 +0100
Subject: [PATCH 07/18] ARM: S5PC1xx: add gpiolib and external/gpio
	interrupt support
In-Reply-To: <20091113232914.GP4808@trinity.fluff.org>
References: <1258014122-18185-1-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-2-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-3-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-4-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-5-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-6-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-7-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-8-git-send-email-m.szyprowski@samsung.com>
	<20091113232914.GP4808@trinity.fluff.org>
Message-ID: <000201ca6694$da21c680$8e655380$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On November 14, 2009 12:29 AM Ben Dooks wrote:

> On Thu, Nov 12, 2009 at 09:21:51AM +0100, Marek Szyprowski wrote:
> > From: Kyungmin Park <kyungmin.park@samsung.com>
> >
> > From: Kyungmin Park <kyungmin.park@samsung.com>
> >
> > Add support for gpiolib calls. This is based on the gpiolib implementation
> > from plat-s3c64xx tree.
> > Add support for external interrupts for GPIO H banks.
> > Add support for GPIO interrupts for all banks.
> >
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  arch/arm/plat-s3c/Kconfig                          |    6 +
> >  arch/arm/plat-s3c/include/plat/gpio-cfg.h          |    1 +
> >  arch/arm/plat-s5pc1xx/Kconfig                      |    3 +
> >  arch/arm/plat-s5pc1xx/Makefile                     |    4 +-
> >  arch/arm/plat-s5pc1xx/cpu.c                        |    5 +
> >  arch/arm/plat-s5pc1xx/gpio-config.c                |   60 +++
> >  arch/arm/plat-s5pc1xx/gpiolib.c                    |  503 ++++++++++++++++++++
> >  .../plat-s5pc1xx/include/plat/gpio-cfg-s5pc1xx.h   |   32 ++
> >  arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h      |   44 ++
> >  arch/arm/plat-s5pc1xx/include/plat/irqs.h          |   15 +-
> >  arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h     |   70 +++
> >  arch/arm/plat-s5pc1xx/irq-eint.c                   |  281 +++++++++++
> >  arch/arm/plat-s5pc1xx/irq-gpio.c                   |  266 +++++++++++
> >  arch/arm/plat-s5pc1xx/irq.c                        |    2 +-
> >  14 files changed, 1287 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/arm/plat-s5pc1xx/gpio-config.c
> >  create mode 100644 arch/arm/plat-s5pc1xx/gpiolib.c
> >  create mode 100644 arch/arm/plat-s5pc1xx/include/plat/gpio-cfg-s5pc1xx.h
> >  create mode 100644 arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h
> >  create mode 100644 arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
> >  create mode 100644 arch/arm/plat-s5pc1xx/irq-eint.c
> >  create mode 100644 arch/arm/plat-s5pc1xx/irq-gpio.c
> >
> > diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
> > index 8931c5f..f155a84 100644
> > --- a/arch/arm/plat-s3c/Kconfig
> > +++ b/arch/arm/plat-s3c/Kconfig
> > @@ -159,6 +159,12 @@ config S3C_GPIO_CFG_S3C64XX
> >  	  Internal configuration to enable S3C64XX style GPIO configuration
> >  	  functions.
> >
> > +config S5P_GPIO_CFG_S5PC1XX
> > +	bool
> > +	help
> > +	  Internal configuration to enable S5PC1XX style GPIO configuration
> > +	  functions.
> > +
> >  # DMA
> >
> >  config S3C_DMA
> > diff --git a/arch/arm/plat-s3c/include/plat/gpio-cfg.h b/arch/arm/plat-s3c/include/plat/gpio-cfg.h
> > index 29cd6a8..7e73429 100644
> > --- a/arch/arm/plat-s3c/include/plat/gpio-cfg.h
> > +++ b/arch/arm/plat-s3c/include/plat/gpio-cfg.h
> > @@ -62,6 +62,7 @@ struct s3c_gpio_cfg {
> >  #define S3C_GPIO_INPUT	(S3C_GPIO_SPECIAL(0))
> >  #define S3C_GPIO_OUTPUT	(S3C_GPIO_SPECIAL(1))
> >  #define S3C_GPIO_SFN(x)	(S3C_GPIO_SPECIAL(x))
> > +#define S3C_GPIO_IRQ	(S3C_GPIO_SPECIAL(0xf))
> 
> I believ this to be wrong, this certainly won't work on at least some of
> the S3C64XX GPIO banks. It is also unused in this patch.

Right, I will remove it from this patch.
 
> I'm not sure whether to just apply this one and remove this definition
> or ask for a response on why it should be in here?

I will send a new updated patch series.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
