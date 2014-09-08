From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 8 Sep 2014 13:31:58 +0200
Subject: [PATCH v2] ARM: dt: fix up PL011 device tree bindings
In-Reply-To: <1399887437-32154-1-git-send-email-linus.walleij@linaro.org>
References: <1399887437-32154-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdai=GX694hH1VxfMiGXcf7YH3wTE9HVS3hHA_zFFT28fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 11:37 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> Make the map match the reality, the current binding text is
> nonsense:
>
> - The clock required for the clocking of the serial port
>   must come first and is not optional (as the driver will
>   otherwise proceed to grab and use the apb_pclk as uartclk),
>   and the apb_pclk that clocks the logic must come second
>   as the code will retrieve the first clock by index,
>   whereas the PrimeCell but will explicitly look for
>   "apb_pclk" so this can be specified later, as it is
>   looked up by name.
>
> - The pin control state "default" is the only mandated
>   state, the sleep state is entirely optional.
>
> We also add an example to avoid further confusion.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Rename amba_pclk to apb_pclk
> - Split clock/clocks properties and indicate that listin one
>   clock only is deprecated

I don't see either this or Mark's related patch being applied and the DT
binding for PL011 left in a sad state. Can we please apply this?

Yours,
Linus Walleij
