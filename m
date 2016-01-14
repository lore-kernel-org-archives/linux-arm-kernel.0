From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Jan 2016 10:02:12 +0100
Subject: [PATCH -next] arm: Select GPIO_GENERIC_PLATFORM for CRAGG_6410
In-Reply-To: <1452531649-14940-1-git-send-email-linux@roeck-us.net>
References: <1452531649-14940-1-git-send-email-linux@roeck-us.net>
Message-ID: <CACRpkdbH6jCyzJK=LM4mPpdLPrQ4KMkHuedAPfWU4tg1K6FaBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 6:00 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> Since commit 0f4630f3720e ("gpio: generic: factor into gpio_chip struct"),
> all users of struct bgpio_pdata depend on GPIO_GENERIC.
>
> This results in the following build error.
>
> arch/arm/mach-s3c64xx/mach-crag6410.c:270:3: warning:
>         excess elements in struct initializer
> arch/arm/mach-s3c64xx/mach-crag6410.c:270:3: warning:
>         (near initialization for '(anonymous)')
> arch/arm/mach-s3c64xx/mach-crag6410.c:271:2: error:
>         invalid use of undefined type 'struct bgpio_pdata'
>
> Fixes: 0f4630f3720e ("gpio: generic: factor into gpio_chip struct")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I don't know if this is the correct way to fix this problem.
> If not, please consider this to be a bug report.

I think this is fixed by Arnds patch:
http://marc.info/?l=linux-gpio&m=145237423205247&w=2

Can you verify that?

Yours,
Linus Walleij
