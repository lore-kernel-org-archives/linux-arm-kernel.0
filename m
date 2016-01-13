From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Jan 2016 16:01:19 +0100
Subject: [PATCH] gpio: generic: make bgpio_pdata always visible
In-Reply-To: <21095568.bdP2eOAsBs@wuerfel>
References: <21095568.bdP2eOAsBs@wuerfel>
Message-ID: <CACRpkdZd6sToPvGXtjrXEvoHyARfL9gz=t91Q_Qmawwu5_A8Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 9, 2016 at 10:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Board files that define their own bgpio_pdata are broken when
> CONFIG_GPIO_GENERIC is disabled and the bgpio_pdata structure
> definition is hidden by the #ifdef:
>
> arch/arm/mach-clps711x/board-autcpu12.c:148:15: error: variable 'autcpu12_mmgpio_pdata' has initializer but incomplete type
>  static struct bgpio_pdata autcpu12_mmgpio_pdata __initdata = {
> arch/arm/mach-clps711x/board-autcpu12.c:149:2: error: unknown field 'base' specified in initializer
>   .base = AUTCPU12_MMGPIO_BASE,
>
> Since the board files should generally not care what drivers are
> enabled, this makes the structure definition visible again.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 0f4630f3720e ("gpio: generic: factor into gpio_chip struct")

Thanks a lot, patch applied!

Yours,
Linus Walleij
