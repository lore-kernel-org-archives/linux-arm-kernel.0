From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 24 Aug 2010 16:40:21 +0200
Subject: [PATCH 1/3] h1940: use gpiolib for latch access
In-Reply-To: <201008241704.07384.anarsoul@gmail.com>
References: <1282230003-2020-1-git-send-email-anarsoul@gmail.com>
	<201008241549.51513.marek.vasut@gmail.com>
	<201008241704.07384.anarsoul@gmail.com>
Message-ID: <201008241640.21488.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 24. srpna 2010 16:04:00 Vasily Khoruzhick napsal(a):
> ? ????????? ?? 24 ??????? 2010 16:49:51 ????? Marek Vasut ???????:
> > > +	ret = gpio_request(H1940_LATCH_BLUETOOTH_POWER, dev_name(&pdev-
> >
> >dev));
> >
> > This should contain the name of the GPIO, not dev_name I assume.
> 
> Ok
> 
> > > +	if (ret) {
> > > +		gpio_free(S3C2410_GPH(1));
> > 
> > What's this constant (the 1) here ? Maybe some sane #define wont hurt or
> > comment around it.
> 
> GPH(1) specifies gpio bit, that's not magic constant.

Defining S3C2410_GPH_GPIONAME for each bit might be better then.

> 
> > > +#ifndef __ASSEMBLY__
> > > +#define H1940_LATCH		((void __force __iomem *)0xF8000000)
> > > +#else
> > > +#define H1940_LATCH		0xF8000000
> > > +#endif
> > 
> > Is the __ASSEMBLY__ really needed ? You can establish mapping when the
> > kernel boots (looks like you're doing that already) but then use
> > __raw_readX __raw_writeX to access that space instead of this stuff
> > above.
> 
> Uh, I just moved this code from another file, not sure if __ASSEMBLY__ is
> necessary, I'll remove it if it is not.

Well this isn't included in any assembly file. So it's not. Also, I'd be happier 
if you could fix it the way I outlined.

Check for example mach-pxa/balloon3.c and how NAND access is done there. Cheers
> 
> Thanks for review :)

You're welcome.
> 
> Regards
> Vasily
