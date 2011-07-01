From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Jul 2011 19:23:13 +0200
Subject: [PATCH 2/3] Samsung SoC: ready to use NTC value inside kernel
In-Reply-To: <20110701155941.GA23784@opensource.wolfsonmicro.com>
References: <1309422387-11546-1-git-send-email-myungjoo.ham@samsung.com>
	<BANLkTin3bu4Xf0cS0EkASvYXG0AdW+eprQ@mail.gmail.com>
	<20110701155941.GA23784@opensource.wolfsonmicro.com>
Message-ID: <201107011923.13324.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 July 2011, Mark Brown wrote:
> On Fri, Jul 01, 2011 at 05:15:05PM +0200, Linus Walleij wrote:
> 
> > There is no clean nice ADC subsystem though, and that feels
> > like a big problem to drivers like this (and no I don't like the AB8500
> > GPADC living in MFD either) so if you'd like to create a ADC
> > subsystem just go ahead, there is something in drivers/staging/iio/adc
> > but that had another problem last time I looked: it was only intended
> > for userspace control, not in-kernel use.

Agreed.

> The other issue is that it's designed for high volume data and these
> AUXADCs tend to be relatively slow.  That said I've had some discussions
> with Jonathan about supporting these devices via IIO and he seems to be
> coming round to the idea that we could integrate support.  Not sure how
> fast IIO is progressing to mainline, though.

I think IIO is progressing well and I would rather base products on that
while it's in staging than having a random out-of-tree driver. It seems
to fit the purpose of this driver, though not the in-kernel uses that
Linus mentioned above.

We have a bunch of things that seem to me like they should live together:
gpio, pinmux, pwm and adc. There are ongoing discussions about pinmux
and pwm subsystems right now, so it might be the right time to discuss
where we are going with these in general.

With regard to IIO, that could live on a higher level and just provide
a user interface on top of the generic in-kernel abstraction for adc.

	Arnd
