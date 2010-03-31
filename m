From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 31 Mar 2010 09:15:38 +0300
Subject: [PATCH 3/4] s3c244x: configure GPG13-15 as input before suspend
In-Reply-To: <20100331011337.GM31126@trinity.fluff.org>
References: <1269109209-26237-1-git-send-email-anarsoul@gmail.com>
	<1269109209-26237-4-git-send-email-anarsoul@gmail.com>
	<20100331011337.GM31126@trinity.fluff.org>
Message-ID: <201003310915.44139.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 31 ????? 2010 04:13:37 ????? Ben Dooks ???????:

> > +#ifdef CONFIG_S3C_DEV_NAND
> > +	/* According to S3C2442 user's manual, page 7-17,
> > +	 * when the system is operating in NAND boot mode,
> > +	 * the hardware pin configuration - EINT[23:21] ???
> > +	 * must be set as input for starting up after
> > +	 * wakeup from sleep mode
> > +	 */
> > +	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPIO_INPUT);
> > +	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPIO_INPUT);
> > +	s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPIO_INPUT);
> 
> Please don't do this conditionally, we can compile kernels supporting
> many machines, some of the machines might not be using this boot method.
> 
> I'll think over the solution.
> 
> 1) Make each machine add a relevant sysdev to hook suspend/resume.
> 
> 2) Update the nand driver to do this, but would (a) need to check what
>    else is s3c2440 compatible, and (b) it doesn't know if the system
>    has booted from NAND or not.

Maybe it's better to do this in s3c2410_pm_prepare()? I see some machine-
specific gpio configuration there.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100331/2da39d54/attachment.sig>
