From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Sep 2013 10:21:42 +0200
Subject: [PATCH 2/7] misc: ixp4-beeper: switch to use gpiolib
In-Reply-To: <201309102348.55478.arnd@arndb.de>
References: <1378816210-7977-1-git-send-email-linus.walleij@linaro.org>
 <201309102348.55478.arnd@arndb.de>
Message-ID: <CACRpkdYOM=q5C0P+3SYwdGFwMe=0yzPSfG0BYT7p61MahAskZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 11:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 10 September 2013, Linus Walleij wrote:

>> Arnd/Greg: seeking your ACK to take this through the GPIO tree
>> as part of the attempt at cleaning out custom GPIO implementations.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

>> +     if (count) {
>> +             gpio_direction_output(pin, 0);
>>               *IXP4XX_OSRT2 = (count & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE;
>>       } else {
>
> Too bad we can't just clean up all the open-coded mmio accesses as well. It shouldn't
> be hard, but some platforms are full of them, and there is definitely some regression
> potential.

Yeah :-/

I'm poking the IXP4 people a bit, it seems to have a large hobbyist
following due to all the NSLU2 hackers out there so lets see if someone
picks up the challenge to go and clean up this stuff.

Yours,
Linus Walleij
