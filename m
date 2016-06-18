From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 18 Jun 2016 10:29:03 +0200
Subject: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
In-Reply-To: <20160615082705.GW22406@atomide.com>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdaVRTj4jpGQp9nDKo8RAPDPUaApp4jAdBGRgd45bqo2zQ@mail.gmail.com>
 <20160615072404.GB26768@pengutronix.de> <20160615082705.GW22406@atomide.com>
Message-ID: <CACRpkdYHj=A7ns+6xZhzVF=gbt=Tc7zHxgV72qjnXUo4QkpKhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 10:27 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [160615 00:27]:
>> On Wed, Jun 15, 2016 at 08:56:58AM +0200, Linus Walleij wrote:
>> > The way forward is to use the character device and use gpiochip
>> > devices with offset indexes and look up GPIOs by name from the
>> > character devices. If nothing substantial happens I am merging the
>> > final pieces of the GPIO chardev ABI for v4.8 and that is doing all that
>> > sysfs was doing and then some. I just need to change a small thing
>> > before sending the final version for review.
>>
>> Hmm, so /sys/class/gpio was obsoleted before the substitution was ready?
>> I'd say an overlapping of several kernel versions would be good as we
>> cannot expect that userspace changes as fast as the kernel.
>
> Well the /sys/class/gpio is an interface, and we'll have to maintain
> it basically forever as we all know. It also works just fine for simple
> things, so let's make sure it is usable. Having it inconsistent can
> cause nasty side effects upgrading kernels.

The clever approach is that while sysfs GPIO has to be explicitly turned
on with a Kconfig, the character device is mandatory, and people can
rely on it always being present.

This will in my dreams encourage people to move toward using the
chardev.

Any removal of the sysfs depend on real-world users migrating to the
chardev though.

Yours,
Linus Walleij
