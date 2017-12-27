From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 27 Dec 2017 14:51:45 +0100
Subject: [PATCH] Input: misc: gpio_tilt: Delete driver
In-Reply-To: <20171227121547.20558-1-linus.walleij@linaro.org>
References: <20171227121547.20558-1-linus.walleij@linaro.org>
Message-ID: <14171345.p7a3jPx4Si@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Am Mittwoch, 27. Dezember 2017, 13:15:47 CET schrieb Linus Walleij:
> This driver was merged in 2011 as a tool for detecting the orientation
> of a screen. The device driver assumes board file setup using the
> platform data from <linux/input/gpio_tilt.h>. But no boards in the
> kernel tree defines this platform data.
> 
> As I am faced with refactoring drivers to use GPIO descriptors and
> pass decriptor tables from boards, or use the device tree device
> drivers like these creates a serious problem: I cannot fix them and
> cannot test them, not even compile-test them with a system actually
> using it (no in-tree boardfile).
> 
> I suggest to delete this driver and rewrite it using device tree if
> it is still in use on actively maintained systems.
> 
> I can also offer to rewrite it out of the blue using device tree if
> someone promise to test it and help me iterate it.
> 
> Cc: Heiko St?bner <heiko@sntech.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Heiko: not meaning to be militant here, just contain the situation,
> as stated: if you like the driver and can test it, I can reimplement
> it from scratch using device tree.

It seems that piece of hardware (gpio-connected orientation-sensors)
was really only used in the one s3c24xx-based device I hacked on in 2011.

I somehow lost focus from trying to do the s3c24xx devicetree migration
when I started hacking on Rockchip stuff, so while I do have the devices
still around, I don't think I'll find the time and energy trying to get a
recent kernel to run on them anyway, so I'm fine with dropping the driver.
It's simple enough to get reintroduced if someone really finds a device
using it or time to redo the ereader support using devicetree.

So long story short
Acked-by: Heiko Stuebner <heiko@sntech.de>


Heiko
