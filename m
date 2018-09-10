From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2018 09:15:13 +0200
Subject: [PATCH v3 1/3] video: fbdev: omapfb: lcd_ams_delta: use GPIO
 lookup table
In-Reply-To: <20180909225605.16463-2-jmkrzyszt@gmail.com>
References: <20180717231448.14958-1-jmkrzyszt@gmail.com>
 <20180909225605.16463-1-jmkrzyszt@gmail.com>
 <20180909225605.16463-2-jmkrzyszt@gmail.com>
Message-ID: <CACRpkdaunjy-k+ssCxVQTHjzCqGdzn3JRHyon8uU9Q8a3d9BXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 12:55 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Now as Amstrad Delta board - the only user of this driver - provides
> GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
> use the table to locate required GPIO pins.
>
> Declare static variables for storing GPIO descriptors and replace
> gpio_ function calls with their gpiod_ equivalents. Move GPIO lookup
> to the driver probe function so device initialization can be deferred
> instead of aborted if a GPIO pin is not yet available.
>
> Pin naming used by the driver should be followed while respective GPIO
> lookup table is initialized by a board init code.
>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Good work as usual:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

FWIW I think the entire drivers/video/fbdev/omap/*
could be pretty easy to migrate to DRM if you compare
the simple drivers/gpu/drm/pl111 or drivers/gpu/drm/tve200
drivers. Just inspiration! :)

Yours,
Linus Walleij
