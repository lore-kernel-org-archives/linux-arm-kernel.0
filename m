From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Jan 2013 12:06:33 +0100
Subject: [PATCH 1/2] ARM: sunxi: gpio: Add Allwinner SoCs GPIO drivers
In-Reply-To: <50F127A4.907@free-electrons.com>
References: <1357317909-12458-1-git-send-email-maxime.ripard@free-electrons.com>
 <1357317909-12458-2-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkda0yhVvCW9edWBi3XusfS4NaiWqKsoCfLpT9+X5iO-GXg@mail.gmail.com>
 <50F127A4.907@free-electrons.com>
Message-ID: <CACRpkdYK2GN_mhghhHHM+qqZ_tzy2ncu8Rm0Q7T2cagxaj7LUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 12, 2013 at 10:06 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

>> Use gpiochip_add_pin_range() from the GPIO driver.
>>
>> An example is provided in
>> drivers/pinctrl/pinctrl-coh901.c
>
> Ok, will do. But we need to find a way to share the pins arrays between
> the pinctrl and gpio drivers then.
>
> Maybe add a pinctrl-sunxi-pins.h file? or merge the pinctrl and gpio
> drivers?
>
> I'm kind of reluctant to merging the drivers into one single messy file,
> but if that's the way to go, fine.

Well, does it have to be that messy?

You can merge it different ways.

For example there is *no* need to have two different device driver
structs and two probe functions, right?

Just one device named pinctrl that has one state container and
one single dd and probe function. That makes everything sooo
much easier I think.

Just register both a pinctrl and GPIO interface (in that order).

See the recent pinctrl-abx500.c submission for an example on
how to do this.

Yours,
Linus Walleij
