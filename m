From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Jan 2016 08:54:16 -0600
Subject: [PATCH v2] of: drop symbols declared by _OF_DECLARE() from modules
In-Reply-To: <1453394031-16578-1-git-send-email-yamada.masahiro@socionext.com>
References: <1453394031-16578-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAL_Jsq+gk81AYJsPoMtLdXqoXs_q6p=gsa476PObCB8kqYsm=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 10:33 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The users of this macro (OF_EARLYCON_DECLARE, CLK_OF_DECLARE,
> IRQCHIP_DECLARE, etc.) are only parsed in the early boot stage.
> Such symbols contained in modules are never used.
>
> This commit fixes the link error introduced by commit b8d20e06eaad
> ("serial: 8250_uniphier: add earlycon support"); the combination
> of CONFIG_SERIAL_8250_UNIPHIER=m and CONFIG_SERIAL_8250_CONSOLE=y
> fails to link:
>
> ERROR: "early_serial8250_setup" [drivers/tty/serial/8250/8250_uniphier.ko] undefined!
>
> Fixes: b8d20e06eaad ("serial: 8250_uniphier: add earlycon support")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>
> Changes in v2:
>   - Describe the bug fixed by this commit
>
>  include/linux/of.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Rob
