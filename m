From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Jul 2011 17:15:05 +0200
Subject: [PATCH 2/3] Samsung SoC: ready to use NTC value inside kernel
In-Reply-To: <BANLkTikC2zUPamzactXLdLb8Szgs2o9V7w@mail.gmail.com>
References: <1309422387-11546-1-git-send-email-myungjoo.ham@samsung.com>
	<1309422387-11546-3-git-send-email-myungjoo.ham@samsung.com>
	<20110630090013.GP21898@n2100.arm.linux.org.uk>
	<BANLkTikC2zUPamzactXLdLb8Szgs2o9V7w@mail.gmail.com>
Message-ID: <BANLkTin3bu4Xf0cS0EkASvYXG0AdW+eprQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 1, 2011 at 2:28 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:

> Or if the values are only exported through sysfs (HWMON), is the only
> clean way to read such values (w/o extending HWMON itself) to seperate
> the HWMON device driver into two pieces: a platform driver that
> provide values to somewhere sharable in kernel and a HWMON driver that
> reads the values and exports them to sysfs?

Sounds like you could very well separate out the ADC part and have
functions for reading values off them? Compare
drivers/mfd/ab8500-gpadc.c for example, this will be used by a
yet to be submitted HWMON driver for doing ADC.

There is no clean nice ADC subsystem though, and *that* feels
like a big problem to drivers like this (and no I don't like the AB8500
GPADC living in MFD either) so if you'd like to create a ADC
subsystem just go ahead, there is something in drivers/staging/iio/adc
but that had another problem last time I looked: it was only intended
for userspace control, not in-kernel use.

Linus Walleij
