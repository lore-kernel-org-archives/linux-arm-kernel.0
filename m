From: torso.nafi@gmail.com (=?UTF-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?=)
Date: Mon, 8 Feb 2016 10:35:55 +0300
Subject: GPIO-driven RTS on TI hardware with 8250_omap driver
In-Reply-To: <5699870E.8080804@hurleysoftware.com>
References: <CAEo2pzugEO+jnwdWrRqKR3y4Gzveh9MMaZmRrksfgYzMf6WpPA@mail.gmail.com>
 <CAHp75Vd6eTXnwErTZdug_rW51mk2sZv5=nT2800ourp=VEHY=Q@mail.gmail.com>
 <5699870E.8080804@hurleysoftware.com>
Message-ID: <CAEo2pztdP1nPZBn4nkD5gzz-QZx2YgfQdCB5iYqxeUMs6rbApA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2016-01-16 2:55 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
> Please use the helpers in serial_mctrl_gpio.c if you try this.
>
> And please build on top of Matwey's patches, as those will likely be
> the rs485 implementation for the 8250_omap driver soon.

As far as I understand, since em485 callbacks are invoked by timers,
the code is to be executed in atomic context. However certain GPIO
controllers (particularly the OMAP-based one which is used on our
AM335x) require the use of the gpio_*_cansleep() functions, and cannot
work with the atomic-friendly non-cansleep ones. Do the aforementioned
helpers in serial_mctrl_gpio.c address this issue?

Regards,
Ilyas G.
