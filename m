From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 25 Jul 2016 15:27:55 +0200
Subject: [PATCH] arm: dts: sun7i-a20-bananapi: name the GPIO lines
In-Reply-To: <5795A334.3000701@de.bosch.com>
References: <1468496825-4896-1-git-send-email-linux@rempel-privat.de>
 <CACRpkdZLG1Ffdiw3xkP4G0XBr=WDXg2Vbh2Xmgno1PTNhfZHfg@mail.gmail.com>
 <CAGb2v66tf1LcBs69ECW0Xa2OeN0C0NWVyvpC8=4DsVLjAnrO3Q@mail.gmail.com>
 <5795A334.3000701@de.bosch.com>
Message-ID: <CACRpkdYnK=7C=F5hZUo-nYv6Z+Pb+eT7vm1e4hL8N-QgJnuLfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2016 at 7:27 AM, fixed-term.Oleksij.Rempel
<fixed-term.Oleksij.Rempel@de.bosch.com> wrote:
> On 22.07.2016 17:47, Chen-Yu Tsai wrote:
>> On Fri, Jul 22, 2016 at 10:55 PM, Linus Walleij
>> <linus.walleij@linaro.org> wrote:

>>> "LED1" seems like the right name, if this is a GPIO used to drive
>>> a LED.
>>
>> This is GPIO based.
>
> This was not clear to me, marking GPIO pin as peripheral, at moment of
> writing and testing it was a allocated by led driver. Bit for example
> IO-GCLK was free to use for GPIO :).. so do [] actually make sense?

I would say if the hardware is used in GPIO mode, i.e. if the hardware
registers of the GPIO block is written to activate the LED, then it
is "LED1".

If there would be a specific LED driver block that disables the GPIO
block to be used for the same lines and have its registers elsewhere,
it would be "[LED1]".

So proper names "FOO" is for the case where the GPIO output is
used as GPIO.

Yours,
Linus Walleij
