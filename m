From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Mar 2014 10:55:24 +0100
Subject: [PATCH 2/3] ARM/leds: move ARM Versatile LED driver to leds
 subsystem
In-Reply-To: <1394540634.21334.27.camel@hornet>
References: <1393509500-26002-1-git-send-email-linus.walleij@linaro.org>
 <1393509500-26002-2-git-send-email-linus.walleij@linaro.org>
 <1393510075.460580224@f137.i.mail.ru>
 <CACRpkdb+nLnjM7PUtkzmSJLjEC7FOH65sgOB6m-BUPB8YMzxiA@mail.gmail.com>
 <1394540634.21334.27.camel@hornet>
Message-ID: <CACRpkdYhFO+ur-RpwC6geBpuzMa-nghc86oWdCiVMiB2-BsrmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 1:23 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> On Tue, 2014-03-11 at 12:18 +0000, Linus Walleij wrote:

>> On some systems without "real" GPIO the above would lead to
>> compiling in the entire gpiolib (149 KB) just to do this.
>>
>> I would agree more with inventing something like leds-mmio as a
>> separate refactoring after this, i.e. a driver for any memory-mapped
>> LED, which should cover a few cases. What do you think about this
>> idea?
>
> Something like this?
> http://thread.gmane.org/gmane.linux.kernel/1387110 ;-)

Yes.

The current GPIO maintainer is not aligned with the statements
that this is "some kind of GPIO".

Also the fact that this adds some hundred KB of code just to do
this simple thing wasn't brought up.

> But seriously speaking, I did exactly what Alexander mentioned on VE,
> considering the SYS_LED & alikes as "pseudo-gpios".

I just don't agree with that. They aren't GPIO's until used as
such, and push in a huge abstraction layer inbetween the driver
and its hardware for no good reason whatsoever I think.
This is not keeping things simple, it is making things obscure.

Yours,
Linus Walleij
