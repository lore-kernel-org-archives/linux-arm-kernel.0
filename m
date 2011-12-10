From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 10 Dec 2011 01:18:43 +0100
Subject: [PATCH] [RFC] pinctrl: add a driver for Energy Micro's efm32 SoCs
In-Reply-To: <20111209110807.GG27267@pengutronix.de>
References: <1323384057-31452-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF1750B77BD8@HQMAIL01.nvidia.com>
 <20111209010147.GH7913@S2100-06.ap.freescale.net>
 <4EE18403.30604@nvidia.com>
 <20111209043220.GJ7913@S2100-06.ap.freescale.net>
 <4EE192DC.3080209@nvidia.com>
 <20111209051413.GK7913@S2100-06.ap.freescale.net>
 <20111209110807.GG27267@pengutronix.de>
Message-ID: <CACRpkdYpq1phHTTLy875xSr-upiW5BmvKMPO_d-niG+-J14t9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2011 at 12:08 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> I still think it should be "I'm board Y, please set all my pins up for me"

This is basically what the current pinmux hog concept does.

> Drivers should not be bothered with pin muxing *at all*.

Not if they are simple. Like - set them up once and for all and
then forget about it.

It gets problematic when we get to sleep states and the system
need to reconfigure all pins on say idle or deep sleep.

We also have heard about hardware routing the *same*
IO block (an I2C port IIRC) to two different sets of pins at
*runtime*, i.e. route it to pin 1-4 do some traffic, route
it to pin 9-12, do some other traffic...

> There are only
> some corner cases where a driver has to do something with the pin setup
> like for example on i.MX6 where the drive strength setting has to be
> changed with different card speeds.

I fear that is just the top of an iceberg :-P

> There is also no value in being able to say which pins are allocated
> by which driver. All we really want is being able to abstract the
> pinmux in some common way and being able to detect conflicts.

It's a value to have it in debugfs, where it is right now, and that
is optional. It helped me a lot when developing a driver...

Thanks,
Linus Walleij
