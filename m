From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Dec 2012 00:01:17 +0100
Subject: [PATCH] GPIO: MVEBU: Fix so only built when CONFIG_OF_IRQ
In-Reply-To: <1354463099-6121-1-git-send-email-andrew@lunn.ch>
References: <1354463099-6121-1-git-send-email-andrew@lunn.ch>
Message-ID: <CACRpkdbJACeOfjFvwsHaj47Jw-0qPSd_kziOHEJ=PPMmbovQ4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 2, 2012 at 4:44 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> This driver only builds when CONFIG_OF_IRQ is enabled. So add this as
> a dependency. Dockstar, and other none DT boards don't build because
> of this, when all other OF boards are disabled.
>
> Reported-by: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Willy Tarreau <w@1wt.eu>
> ---
>  drivers/gpio/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 6dbc403..4d84c17 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -153,6 +153,7 @@ config GPIO_MSM_V2
>  config GPIO_MVEBU
>         def_bool y
>         depends on PLAT_ORION
> +       depends on OF_IRQ
>         select GPIO_GENERIC
>         select GENERIC_IRQ_CHIP

This does not apply to the GPIO tree, I assume it's intended for the
MVEBU tree.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
