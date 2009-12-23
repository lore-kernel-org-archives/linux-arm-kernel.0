From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Dec 2009 13:37:39 +0000
Subject: [PATCH] pxa: fix gpio_to_irq() for GPIOs on expander chips
In-Reply-To: <f17812d70912230448k62f6d455s17b75050793975ad@mail.gmail.com>
References: <1259148990-10372-1-git-send-email-mad_soft@inbox.ru>
	<74d0deb30912140149hc20c19dy605a259dc3f6e6e0@mail.gmail.com>
	<771cded00912230107v5d2cbb18y733b62b0d6303887@mail.gmail.com>
	<20091223112306.4a45064e@life-in-the-fast-lane>
	<f17812d70912230448k62f6d455s17b75050793975ad@mail.gmail.com>
Message-ID: <20091223133739.GB4799@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2009 at 08:48:21PM +0800, Eric Miao wrote:
> On Wed, Dec 23, 2009 at 6:23 PM, Marc Zyngier <maz@misterjones.org> wrote:

> > We could mimic what s3c2410 does to provide some extra GPIO space for
> > platforms that require it (arch/arm/mach-s3c2410/include/mach/gpio.h):

> > #define ARCH_NR_GPIOS ?? (256 + CONFIG_S3C24XX_GPIO_EXTRA)

> That's going to be making it impossible for mach-* to be built into a
> single kernel (call me ambitious :-).

The S3C stuff does try to support this - S3C24XX_GPIO_EXTRA isn't
selected directly but instead boards select other symbols with
particular values and then "default if ..." is used in Kconfig to set
the largest value that was asked for.
