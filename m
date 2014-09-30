From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Sep 2014 16:11:28 +0200
Subject: [PATCH] gpiolib: fix callers of gpiochip_remove
In-Reply-To: <2923496.zl6JUbOQrZ@wuerfel>
References: <2923496.zl6JUbOQrZ@wuerfel>
Message-ID: <CACRpkdYdwhujkP_66GCNktcvXFOzmGW=3t6BvCSXXMnHu03eEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 3:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> A recent API change made gpiochip_remove return void instead of an
> error value, which broke drivers that use this return value:
>
> gpio/gpio-sch311x.c: In function 'sch311x_gpio_probe':
> gpio/gpio-sch311x.c:286:7: error: void value not ignored as it ought to be
>    if (gpiochip_remove(&priv->blocks[i].chip))
>        ^
>
> This changes the callers that I have found during randconfig testing
> so they no longer depend on the error code.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: e1db1706c86e ("gpio: gpiolib: set gpiochip_remove retval to void")

Hm AFAICT these are already fixes in my GPIO tree
and linux-next...

Am I looking in the wrong place?

Yours,
Linus Walleij
