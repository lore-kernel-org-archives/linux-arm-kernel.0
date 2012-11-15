From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2012 20:09:20 +0100
Subject: [PATCH 01/14] pinctrl: SPEAr: add spi chipselect control driver
In-Reply-To: <CAKohpomLRYAKJ=dNLVsjj1xf=G6xj4EcTpPmhSDvgBYUMXc1mA@mail.gmail.com>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
 <4a92290e8a3b1a19c3a5e864edfa7badfc2af5d0.1352608333.git.viresh.kumar@linaro.org>
 <CACRpkdb9tSUUGQjWdHqRr5rUSyiPgWm2i3-QZq9VbWFY2EAQeQ@mail.gmail.com>
 <CAKohpomLRYAKJ=dNLVsjj1xf=G6xj4EcTpPmhSDvgBYUMXc1mA@mail.gmail.com>
Message-ID: <CACRpkdY+noKODLNUEV4dNM7cJVuRayEhJRjND75Ggm2kBoX1mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 3:19 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 15 November 2012 19:47, Linus Walleij <linus.walleij@linaro.org> wrote:

>> Just one question: since this driver is not using any
>> pinctrl interfaces, why is it under drivers/pinctrl/*?
>>
>> Shouldn't it be under drivers/gpio from a technical
>> point of view?
>>
>> I think I'd accept it under drivers/pinctrl/spear/*
>> if you just want this to keep everything SPEAr-related
>> in one place though, so enlighten me.
>
> That's because they are controlling few pads. They are not
> actually gpio's but just pads that we are controlling.
>
> That's why we thought they are better in this place.

The grouping of drivers in the kernel is about what in-kernel
subsystem interface they're using, not how their electronics
work...

Since this driver is only using the GPIO API it should be
in drivers/gpio/gpio-*.c.

Many, many drivers in drivers/gpio* are controlling pads
too, so it will be in good company ;-)

Yours,
Linus Walleij
