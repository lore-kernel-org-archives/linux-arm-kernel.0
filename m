From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 01 Oct 2010 07:19:16 +0200
Subject: [PATCH 5/6] ARM: Samsung: Add common samsung_gpiolib_to_irq
	function
In-Reply-To: <00fb01cb6124$068a8790$139f96b0$%kim@samsung.com>
References: <1283764347-460-1-git-send-email-m.szyprowski@samsung.com>
	<1283764347-460-6-git-send-email-m.szyprowski@samsung.com>
	<00fb01cb6124$068a8790$139f96b0$%kim@samsung.com>
Message-ID: <00ec01cb6128$34300720$9c901560$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, October 01, 2010 6:49 AM Kukjin Kim wrote:

...

> > diff --git a/arch/arm/plat-samsung/gpiolib.c
> b/arch/arm/plat-samsung/gpiolib.c
> > index c354089..f2dc389 100644
> > --- a/arch/arm/plat-samsung/gpiolib.c
> > +++ b/arch/arm/plat-samsung/gpiolib.c
> > @@ -197,3 +197,11 @@ void __init samsung_gpiolib_add_4bit2_chips(struct
> > s3c_gpio_chip *chip,
> >  		s3c_gpiolib_add(chip);
> >  	}
> >  }
> > +
> > +int samsung_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
> > +{
> > +	struct s3c_gpio_chip *s3c_chip = container_of(chip,
> > +			struct s3c_gpio_chip, chip);
> > +
> > +	return s3c_chip->irq_base + offset;
> > +}
> 
> Hi,
> 
> Following is for your information...
> 
> Moved samsung_gpiolib_to_irq() into plat-samsung/gpio.c because happened
> build error like following after applying this.
> 
> arch/arm/plat-s3c24xx/built-in.o:(.data+0x11c4): undefined reference to
> `samsung_gpiolib_to_irq'
> 
> The reason is that plat-samsung/gpiolib.c is not required for
> s3c24xx...applied anyway with modifying.

I must have missed that plat-samsung/gpiolib.c is not used for s3c-24xx. Thank
You for the fix!

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
