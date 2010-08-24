From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 24 Aug 2010 17:04:00 +0300
Subject: [PATCH 1/3] h1940: use gpiolib for latch access
In-Reply-To: <201008241549.51513.marek.vasut@gmail.com>
References: <1282230003-2020-1-git-send-email-anarsoul@gmail.com>
	<1282230003-2020-2-git-send-email-anarsoul@gmail.com>
	<201008241549.51513.marek.vasut@gmail.com>
Message-ID: <201008241704.07384.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 24 ??????? 2010 16:49:51 ????? Marek Vasut ???????:

> > +	ret = gpio_request(H1940_LATCH_BLUETOOTH_POWER, dev_name(&pdev-
>dev));
> 
> This should contain the name of the GPIO, not dev_name I assume.

Ok

> > +	if (ret) {
> > +		gpio_free(S3C2410_GPH(1));
> 
> What's this constant (the 1) here ? Maybe some sane #define wont hurt or
> comment around it.

GPH(1) specifies gpio bit, that's not magic constant.

> > +#ifndef __ASSEMBLY__
> > +#define H1940_LATCH		((void __force __iomem *)0xF8000000)
> > +#else
> > +#define H1940_LATCH		0xF8000000
> > +#endif
> 
> Is the __ASSEMBLY__ really needed ? You can establish mapping when the
> kernel boots (looks like you're doing that already) but then use
> __raw_readX __raw_writeX to access that space instead of this stuff above.

Uh, I just moved this code from another file, not sure if __ASSEMBLY__ is 
necessary, I'll remove it if it is not.
 
Thanks for review :)

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100824/f6e24406/attachment-0001.sig>
