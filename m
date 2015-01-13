From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Jan 2015 09:01:38 +0100
Subject: [PATCH v5 1/3] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <2063145.N1Hk6vVF2S@wuerfel>
References: <1418342706-14755-2-git-send-email-rjui@broadcom.com>
 <1628217.66frkAqHMc@wuerfel> <548F5433.5090901@broadcom.com>
 <2063145.N1Hk6vVF2S@wuerfel>
Message-ID: <CACRpkdaZ=Yg6YeDh4yR7+YgiJj6CM3v=prB10TK=w=mu8VQNuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 10:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 15 December 2014 13:35:47 Ray Jui wrote:
>>
>> Like I said previously, dynamic GPIO allocation works fine in the
>> kernel, as long as all of our GPIO clients in the kernel use gpiod based
>> API, which is what we will enforce going forward. The only problem is
>> with some of our customers who use GPIO through sysfs and expect fixed
>> global GPIO numbers. Thinking about this more, it's probably not that
>> difficult to add a script for those customers to convert/map the GPIO
>> numbers based on readings parsed from sysfs, so I guess that's fine.
>>
>
> I think we discussed the user space interface a number of times
> in the past, but I forgot the outcome. Either there is already
> a way to name gpio lines uniquely in sysfs, or there should be
> one.

There is one. The struct gpio_chip contains a .names field with
strings giving names to the GPIOs on the chip.

This field does not have standardized DT bindings or anything
but should be used.

Overall the sysfs interface is an abomination for relying on
the notoriously unstable GPIO numberspace and other things.
It was merged when the subsystem lacked a maintainer.

Yours,
Linus Walleij
