From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 11 Mar 2014 16:41:29 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzNdIEFSTS9sZWRzOiBtb3ZlIEFSTSBWZXJzYXRpbGUg?=
 =?UTF-8?B?TEVEIGRyaXZlciB0byBsZWRzIHN1YnN5c3RlbQ==?=
In-Reply-To: <1394540634.21334.27.camel@hornet>
References: <1393509500-26002-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdb+nLnjM7PUtkzmSJLjEC7FOH65sgOB6m-BUPB8YMzxiA@mail.gmail.com>
 <1394540634.21334.27.camel@hornet>
Message-ID: <1394541689.595951116@f330.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????, 11 ????? 2014, 12:23 UTC ?? Pawel Moll <pawel.moll@arm.com>:
> On Tue, 2014-03-11 at 12:18 +0000, Linus Walleij wrote:
> > On Thu, Feb 27, 2014 at 3:07 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> > > ???????, 27 ??????? 2014, 14:58 +01:00 ?? Linus Walleij <linus.walleij@linaro.org>:
> > >> Now that we have converted this driver to a real platform device
> > >> module-based thing, we move the driver down into the LEDs
> > >> subsystem and rename the config option to LEDS_VERSATILE.
> > >
> > > In fact, it can be converted to use basic-mmio-gpio => leds-gpio.
> > 
> > Hm, yeah I see what you mean. However this register is not described
> > as a GPIO register, and on all Versatile/RealView boards these signals
> > are soldered to LEDs, so they are not general purpose at all.
> > 
> > On some systems without "real" GPIO the above would lead to
> > compiling in the entire gpiolib (149 KB) just to do this.
> > 
> > I would agree more with inventing something like leds-mmio as a
> > separate refactoring after this, i.e. a driver for any memory-mapped
> > LED, which should cover a few cases. What do you think about this
> > idea?
> 
> Something like this?
> http://thread.gmane.org/gmane.linux.kernel/1387110 ;-)
> 
> But seriously speaking, I did exactly what Alexander mentioned on VE,
> considering the SYS_LED & alikes as "pseudo-gpios".

It turns out everything has already been invented :)

---
