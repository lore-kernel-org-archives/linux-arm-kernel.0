From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 1 Jul 2011 08:59:42 -0700
Subject: [PATCH 2/3] Samsung SoC: ready to use NTC value inside kernel
In-Reply-To: <BANLkTin3bu4Xf0cS0EkASvYXG0AdW+eprQ@mail.gmail.com>
References: <1309422387-11546-1-git-send-email-myungjoo.ham@samsung.com>
	<1309422387-11546-3-git-send-email-myungjoo.ham@samsung.com>
	<20110630090013.GP21898@n2100.arm.linux.org.uk>
	<BANLkTikC2zUPamzactXLdLb8Szgs2o9V7w@mail.gmail.com>
	<BANLkTin3bu4Xf0cS0EkASvYXG0AdW+eprQ@mail.gmail.com>
Message-ID: <20110701155941.GA23784@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2011 at 05:15:05PM +0200, Linus Walleij wrote:

> There is no clean nice ADC subsystem though, and *that* feels
> like a big problem to drivers like this (and no I don't like the AB8500
> GPADC living in MFD either) so if you'd like to create a ADC
> subsystem just go ahead, there is something in drivers/staging/iio/adc
> but that had another problem last time I looked: it was only intended
> for userspace control, not in-kernel use.

The other issue is that it's designed for high volume data and these
AUXADCs tend to be relatively slow.  That said I've had some discussions
with Jonathan about supporting these devices via IIO and he seems to be
coming round to the idea that we could integrate support.  Not sure how
fast IIO is progressing to mainline, though.
