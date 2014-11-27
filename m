From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Nov 2014 14:40:42 +0100
Subject: [PATCH v2] ARM: dt: fix up PL011 device tree bindings
In-Reply-To: <1399887437-32154-1-git-send-email-linus.walleij@linaro.org>
References: <1399887437-32154-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdbQYSo0pQxPDXEPw-yMm8pA0oCnYJa2+v==pAgKWax5UA@mail.gmail.com>
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

PING on this, 6 months and the bindings still look like hell.

Greg can you pick this up through the serial tree?

I can resend the patch if you don't have it...

Yours,
Linus Walleij
