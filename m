From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 24 Jan 2011 20:05:36 +0100
Subject: [PATCH] ARM: print FPGA info on plat-versatile variants
In-Reply-To: <20110124173004.GA27080@n2100.arm.linux.org.uk>
References: <1287422635-21492-1-git-send-email-linus.walleij@stericsson.com>
	<20110124173004.GA27080@n2100.arm.linux.org.uk>
Message-ID: <AANLkTintRdFf0RaK6kEtT-Tsy2NvYPhK43NqcLMnV_bT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/24 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Oct 18, 2010 at 07:23:55PM +0200, Linus Walleij wrote:
>> This adds a small piece of code that displays some basic FPGA
>> characteristics for the Integrator, Versatile, RealView and
>> Versatile Express reference platforms, then hooks it into
>> respective platform startup code.
>
> Firstly, isn't this shown on the character LCD screen at boot, so I wonder
> what the value of this is.

Two things: the RealView EB, PB11MPCore, PBA8, PBA9 nor
the integrator board have the character LCD.

Then I've added a driver for the Char LCD so that you loose this
information if you use the LCD for anything, but yes, it is available
while booting.

> Secondly, with your revised patch, it could really do without adding more
> non-timer stuff back into the timer initialization function when I've just
> removed non-timer stuff from it. ?I don't see that there's anything
> particularly urgent about printing this information, so can't it be a
> normal initcall?

No problem, this was mainly to get it out as early as possible.
I'll fix it up.

Thanks,
Linus Walleij
