From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 19 Aug 2010 16:56:27 +0300
Subject: [PATCH RFC] h1940: use gpiolib for latch access
In-Reply-To: <4C5986AB.40103@simtec.co.uk>
References: <1280076072-1049-1-git-send-email-anarsoul@gmail.com>
	<4C5986AB.40103@simtec.co.uk>
Message-ID: <201008191656.36727.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 4 ??????? 2010 18:26:35 ????? Ben Dooks ???????:
> >  	/* Configures BT serial port GPIOs */
> >  	s3c_gpio_cfgpin(S3C2410_GPH(0), S3C2410_GPH0_nCTS0);
> > 
> > -	s3c_gpio_cfgpull(S3C2410_GPH(0), S3C_GPIO_PULL_NONE);
> > +	s3c_gpio_setpull(S3C2410_GPH(0), S3C_GPIO_PULL_NONE);
> > 
> >  	s3c_gpio_cfgpin(S3C2410_GPH(1), S3C2410_GPIO_OUTPUT);
> > 
> > -	s3c_gpio_cfgpull(S3C2410_GPH(1), S3C_GPIO_PULL_NONE);
> > +	s3c_gpio_setpull(S3C2410_GPH(1), S3C_GPIO_PULL_NONE);
> > 
> >  	s3c_gpio_cfgpin(S3C2410_GPH(2), S3C2410_GPH2_TXD0);
> > 
> > -	s3c_gpio_cfgpull(S3C2410_GPH(2), S3C_GPIO_PULL_NONE);
> > +	s3c_gpio_setpull(S3C2410_GPH(2), S3C_GPIO_PULL_NONE);
> > 
> >  	s3c_gpio_cfgpin(S3C2410_GPH(3), S3C2410_GPH3_RXD0);
> > 
> > -	s3c_gpio_cfgpull(S3C2410_GPH(3), S3C_GPIO_PULL_NONE);
> > +	s3c_gpio_setpull(S3C2410_GPH(3), S3C_GPIO_PULL_NONE);
> 
> Is this an error, or have you merged a part of a different patch
> into this one?

Will move into separate patch
 
> > +#define H1940_PA_LATCH		(S3C2410_CS2)
> > +
> > +#define H1940_LATCH_GPIO(x)		(S3C_GPIO_END + x)
> > +
> > +#define H1940_LATCH_BIT(x)		(1 << (x + 16 - S3C_GPIO_END))
> 
> you probably want an () around the 'x's in the above defines.

Yep
 
> computing the bit seperately to the call to h1940_latch_control
> would have made the code easier to read.
> 
> > +	h1940_latch_control(value ? 0 : (1 << (offset + 16)),
> > +		value ? (1 << (offset + 16)) : 0);

Ok

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100819/9c1b9448/attachment.sig>
