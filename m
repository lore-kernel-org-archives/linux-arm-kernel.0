From: tony@atomide.com (Tony Lindgren)
Date: Wed, 15 Jun 2016 01:27:06 -0700
Subject: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
In-Reply-To: <20160615072404.GB26768@pengutronix.de>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdaVRTj4jpGQp9nDKo8RAPDPUaApp4jAdBGRgd45bqo2zQ@mail.gmail.com>
 <20160615072404.GB26768@pengutronix.de>
Message-ID: <20160615082705.GW22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [160615 00:27]:
> On Wed, Jun 15, 2016 at 08:56:58AM +0200, Linus Walleij wrote:
> > The way forward is to use the character device and use gpiochip
> > devices with offset indexes and look up GPIOs by name from the
> > character devices. If nothing substantial happens I am merging the
> > final pieces of the GPIO chardev ABI for v4.8 and that is doing all that
> > sysfs was doing and then some. I just need to change a small thing
> > before sending the final version for review.
> 
> Hmm, so /sys/class/gpio was obsoleted before the substitution was ready?
> I'd say an overlapping of several kernel versions would be good as we
> cannot expect that userspace changes as fast as the kernel.

Well the /sys/class/gpio is an interface, and we'll have to maintain
it basically forever as we all know. It also works just fine for simple
things, so let's make sure it is usable. Having it inconsistent can
cause nasty side effects upgrading kernels.

Naturally I don't have any objections for adding a character device :)

Regards,

Tony
