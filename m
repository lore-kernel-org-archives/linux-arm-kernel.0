From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Feb 2012 14:08:23 +0100
Subject: [PATCH 1/2] Documentation/gpio.txt: Explain expected pinctrl
 interaction
In-Reply-To: <20120221124409.GL22562@n2100.arm.linux.org.uk>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
 <20120220073941.GC22562@n2100.arm.linux.org.uk>
 <CACRpkdbMFN3=XTSg1oE310eTHecrs6XaMz+DCNYJzwOg8JEEiQ@mail.gmail.com>
 <20120221110618.GJ22562@n2100.arm.linux.org.uk>
 <CACRpkdYzRu4VPKPgxuttuvSDCpfHjvBGGq1rFEDExv1PsoLG=w@mail.gmail.com>
 <20120221124409.GL22562@n2100.arm.linux.org.uk>
Message-ID: <CACRpkda3ZYptmExYbMuQv1LJqf=hD8g8jcPSP8Lij5-xaYd2GQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 1:44 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

>> (It'd probably need the SA1100 to be a bit more strict in using
>> gpiolib in place for the direct assignments though, else the
>> abstractions get a bit pointless anyway.)
>
> That's mostly happened through my recent set of 100 or so patches.
> There's a few areas where that's not quite as easy as it should be,
> but on the whole, it's mostly complete.

Excellent!

> The other thing I forgot to mention, and I suspect it's particular to
> SA11x0, is that the GPDR must be set correctly according to the special
> function as well as GAFR. ?So, if a special function involves driving
> a pin, the pin must be set as an output in GPDR. ?Conversely, if the
> special function involves input only, the pin must be set as an input
> in GPDR.
>
> So, on SA11x0, gpio and pin configuration are intimately linked.

It's quite common I think, many platforms have an intimate
relation between GPIO and muxes/altfunctions. For example
it is common that the hardware engineer doesn't helpfully
enable on-die pull-ups on the I2C bus even though the I2C
block is muxed in, you have to go in and set the pull-up bits
separately from muxing the I2C in...

Basically it's expected from a generic pad I/O cell being
arrayed into a GPIO block to expose these things in the same
set of registers.

I made some presentation last week partly describing how
some hardware engineers I know go about creating GPIO
controllers from simpler I/O pad cells:
http://www.df.lth.se/~triad/papers/pincontrol.pdf

Yours,
Linus Walleij
