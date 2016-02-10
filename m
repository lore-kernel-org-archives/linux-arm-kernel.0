From: kernel@martin.sperl.org (Martin Sperl)
Date: Wed, 10 Feb 2016 18:42:53 +0100
Subject: serial: clk: bcm2835: Strange effects when using aux-uart in
 console
In-Reply-To: <56BB719B.8070007@i2se.com>
References: <A5F427B7-9B78-4892-9722-69418C4D0C10@martin.sperl.org>
 <56BB719B.8070007@i2se.com>
Message-ID: <3C1ABADD-C0B2-430A-99B3-EAF9B56D0A49@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 10.02.2016, at 18:21, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> Hi,
>> Maybe someone has gotten any idea?
> 
> this sounds like an issue i had with the compute module here:
> 
> http://permalink.gmane.org/gmane.linux.kernel.rpi/2197
> 
This one was fixed - if I remember correctly.

> Unfortunately i don't have the cm anymore.
> 
> Maybe you can try this downstream patch:
> 
> https://github.com/raspberrypi/linux/commit/09041f7ccbd1cde792edae91c41266886d5d1382
> 
I wonder if it is really interrupts that are the root cause
to mee it looks like a clock problem - especially as it actually
impacts the PL011 driver and not the aux driver?

And initializing the other way (pl011 is console, aux as tty)
works without any issues - so it HAS to do with accessing the
PL011 or the clock framework.

Martin
