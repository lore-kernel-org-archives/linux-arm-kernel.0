From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Nov 2016 09:47:20 +0100
Subject: [PATCH] ARM: ux500: fix prcmu_is_cpu_in_wfi() calculation
In-Reply-To: <20161116152047.3336967-1-arnd@arndb.de>
References: <20161116152047.3336967-1-arnd@arndb.de>
Message-ID: <CACRpkdb1RdDCjT3ChiJdF8WZHp-Sb1un1tvSOh3uShZn2DaZ-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 4:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> This function clearly never worked and always returns true,
> as pointed out by gcc-7:
>
> arch/arm/mach-ux500/pm.c: In function 'prcmu_is_cpu_in_wfi':
> arch/arm/mach-ux500/pm.c:137:212: error: ?: using integer constants in boolean context, the expression will always evaluate to 'true' [-Werror=int-in-bool-context]
>
> With the added braces, the condition actually makes sense.
>
> Fixes: 34fe6f107eab ("mfd : Check if the other db8500 core is in WFI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Will you apply it directly to ARM SoC or should I queue it and
send it with a pull request?

Yours,
Linus Walleij
