From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Dec 2013 13:16:38 +0100
Subject: [PATCH v2 1/1] gpio: twl4030: Fix regression for twl gpio LED
 output
In-Reply-To: <1386235415-27670-1-git-send-email-rogerq@ti.com>
References: <1386156871-7639-2-git-send-email-rogerq@ti.com>
 <1386235415-27670-1-git-send-email-rogerq@ti.com>
Message-ID: <CACRpkdb3viraX6yQhUHokSVfN2qXxcc5cd1YpjPGfeDMy64p+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 5, 2013 at 10:23 AM, Roger Quadros <rogerq@ti.com> wrote:

> Commit 0b2aa8be introduced a regression that causes failure
> in setting LED GPO direction to OUT.
>
> This causes USB host probe failures for Beagleboard C4.
>
> [    2.075469] platform usb_phy_gen_xceiv.2: Driver usb_phy_gen_xceiv requests probe deferral
> [    2.090454] hsusb2_vcc: Failed to request enable GPIO510: -22
> [    2.100982] reg-fixed-voltage reg-fixed-voltage.0.auto: Failed to register regulator: -22
> [    2.109954] reg-fixed-voltage: probe of reg-fixed-voltage.0.auto failed with error -22
>
> direction_out/direction_in must return 0 if the operation succeeded.
>
> Also, don't update direction flag and output data if twl4030_set_gpio_direction()
> failed inside twl_direction_out();
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Patch applied for fixes with Tony's ACK.

Thanks!
Linus Walleij
