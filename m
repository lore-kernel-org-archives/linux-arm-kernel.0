From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Jan 2016 16:17:16 +0100
Subject: [PATCH] gpio: moxart: fix build regression
In-Reply-To: <4110228.QqTjkKaKSX@wuerfel>
References: <4110228.QqTjkKaKSX@wuerfel>
Message-ID: <CACRpkdabuSueuTyUH-1VBO883eR_eyh8Kbp0k6SMCrWQf8c+vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2016 at 2:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> A cleanup patch replaced bgpio_chip with gpio_chip but missed
> two references to the bgpio_chip:
>
> drivers/gpio/gpio-moxart.c:60:19: error: use of undeclared identifier 'bgc'; did you mean 'gc'?
>         gc->bgpio_data = bgc->read_reg(bgc->reg_set);
> drivers/gpio/gpio-moxart.c:35:20: note: 'gc' declared here
> drivers/gpio/gpio-moxart.c:60:33: error: use of undeclared identifier 'bgc'; did you mean 'gc'?
>         gc->bgpio_data = bgc->read_reg(bgc->reg_set);
>
> This adds the missing change.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 0f4630f3720e ("gpio: generic: factor into gpio_chip struct")

Patch applied, sorry for the mess...

Yours,
Linus Walleij
