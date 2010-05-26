From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 26 May 2010 23:04:01 +0200
Subject: Controlling Driver Load Order
In-Reply-To: <AANLkTikzDvWakd7JW3DzTHinjS3dAlqzPx6K8V2qMDG7@mail.gmail.com>
References: <AANLkTikzDvWakd7JW3DzTHinjS3dAlqzPx6K8V2qMDG7@mail.gmail.com>
Message-ID: <AANLkTinkY8JYh44UOEPflBUDyQ2wat_AKShRjA3HPxrf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/26 Robert Emanuele <rob@emanuele.us>:

> On my at91sam9g45 platform I need my i2c drivers to load before the
> framebuffer driver. ?The i2c drivers control a power management IC
> which is needed to enable the graphics controller.
>
> Is there a way to set up that order?

The usual trick (which you can find in a lot of other I2C busses) is to use
a core_initcall() instead of module_init().

You find the different init levels in include/linux/init.h

Yours,
Linus Walleij
