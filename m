From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 11:09:11 +0100
Subject: [PATCH] pinctrl: uniphier: set input-enable before pin-muxing
In-Reply-To: <1445329509-6252-1-git-send-email-yamada.masahiro@socionext.com>
References: <1445329509-6252-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZwnrpJkv+70UsWjOVMb3uUNnxG8TxK235=OaeHafDk+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 10:25 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> While IECTRL is disabled, input signals are pulled-down internally.
> If pin-muxing is set up first, glitch signals (Low to High transition)
> might be input to hardware blocks.
>
> Bad case scenario:
> [1] The hardware block is already running before pinctrl is handled.
>    (the reset is de-asserted by default or by a firmware, for example)
> [2] The pin-muxing is set up.  The input signals to hardware block
>     are pulled-down by the chip-internal biasing.
> [3] The pins are input-enabled.  The signals from the board reach the
>     hardware block.
>
> Actually, one invalid character is input to the UART blocks for such
> SoCs as PH1-LD4, PH1-sLD8, where UART devices start to run at the
> power on reset.
>
> To avoid such problems, pins should be input-enabled before muxing.
>
> Fixes: 6e9088920258 ("pinctrl: UniPhier: add UniPhier pinctrl core support")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reported-by: Dai Okamura <okamura.dai@socionext.com>
> ---
>
> Hi Linus,
>
> If it is not too late, please apply this fix for Linux 4.3.

It's too late at this point.

Patch is applied for devel and will come into v4.4 and from there
to -stable.

Yours,
Linus Walleij
