From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 01 Dec 2010 14:28:17 +0900
Subject: [PATCH v4] ARM: s3c244x: Fix mess with gpio {set,get}_pull
	callbacks
In-Reply-To: <4CF55785.5090403@metafoo.de>
References: <201011301701.03443.anarsoul@gmail.com>
	<1291146383-16215-1-git-send-email-anarsoul@gmail.com>
	<4CF55785.5090403@metafoo.de>
Message-ID: <000d01cb9118$9136c740$b3a455c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lars-Peter Clausen wrote:
> 
> > +static int s3c_gpio_setpull_1(struct s3c_gpio_chip *chip,
> > +			 unsigned int off, s3c_gpio_pull_t pull,
> > +			 s3c_gpio_pull_t updown)
> >  {
> >  	void __iomem *reg = chip->base + 0x08;
> >  	u32 pup = __raw_readl(reg);
> >
> > -	pup = __raw_readl(reg);
> > -
> > -	if (pup == S3C_GPIO_PULL_UP)
> > +	if (pup == updown)
> This should be pull == updown, otherwise looks fine to me
> 
Yeah, I meant this.

> >  		pup &= ~(1 << off);
> >  	else if (pup == S3C_GPIO_PULL_NONE)

pull == S3C_GPIO_PULL_NONE?

> >  		pup |= (1 << off);

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
