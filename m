From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 11 Mar 2014 12:23:54 +0000
Subject: [PATCH 2/3] ARM/leds: move ARM Versatile LED driver to leds
 subsystem
In-Reply-To: <CACRpkdb+nLnjM7PUtkzmSJLjEC7FOH65sgOB6m-BUPB8YMzxiA@mail.gmail.com>
References: <1393509500-26002-1-git-send-email-linus.walleij@linaro.org>
 <1393509500-26002-2-git-send-email-linus.walleij@linaro.org>
 <1393510075.460580224@f137.i.mail.ru>
 <CACRpkdb+nLnjM7PUtkzmSJLjEC7FOH65sgOB6m-BUPB8YMzxiA@mail.gmail.com>
Message-ID: <1394540634.21334.27.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-03-11 at 12:18 +0000, Linus Walleij wrote:
> On Thu, Feb 27, 2014 at 3:07 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> > ???????, 27 ??????? 2014, 14:58 +01:00 ?? Linus Walleij <linus.walleij@linaro.org>:
> >> Now that we have converted this driver to a real platform device
> >> module-based thing, we move the driver down into the LEDs
> >> subsystem and rename the config option to LEDS_VERSATILE.
> >
> > In fact, it can be converted to use basic-mmio-gpio => leds-gpio.
> 
> Hm, yeah I see what you mean. However this register is not described
> as a GPIO register, and on all Versatile/RealView boards these signals
> are soldered to LEDs, so they are not general purpose at all.
> 
> On some systems without "real" GPIO the above would lead to
> compiling in the entire gpiolib (149 KB) just to do this.
> 
> I would agree more with inventing something like leds-mmio as a
> separate refactoring after this, i.e. a driver for any memory-mapped
> LED, which should cover a few cases. What do you think about this
> idea?

Something like this?
http://thread.gmane.org/gmane.linux.kernel/1387110 ;-)

But seriously speaking, I did exactly what Alexander mentioned on VE,
considering the SYS_LED & alikes as "pseudo-gpios".

Pawel
