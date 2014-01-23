From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Jan 2014 09:43:07 +0100
Subject: [PATCH] vt8500: pinctrl: Change devicetree data parsing
In-Reply-To: <1390458701-30238-1-git-send-email-linux@prisktech.co.nz>
References: <1390458701-30238-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <CACRpkdaFJphJdf6hyKoYEZ_wXikwRiwzMgtL=hY+3B8WrBnQaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 7:31 AM, Tony Prisk <linux@prisktech.co.nz> wrote:

> Due to an assumption in the VT8500 pinctrl driver, the value passed
> from devicetree for 'wm,pull' was not explicitly translated before
> being passed to pinconf.
>
> With changes to 'enum pin_config_param', PIN_CONFIG_BIAS_PULL_(UP/DOWN)
> no longer map 1-to-1 with the expected values in devicetree.
>
> This patch adds a small translation between the devicetree values (0..2)
> and the enum pin_config_param equivalent values.
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

Isn't this a regression fix for stable?

> +       switch (pull) {
> +       case 0:
> +               pull = PIN_CONFIG_BIAS_DISABLE;
> +               break;
> +       case 1:
> +               pull = PIN_CONFIG_BIAS_PULL_DOWN;
> +               break;
> +       case 2:
> +               pull = PIN_CONFIG_BIAS_PULL_UP;
> +               break;
> +       }
>         configs[0] = pull;

1. You're not adding a default: clause (I bet the static checkers will
warn about this!)

2. Please conjure a different variable name for the thing that
actually gets set in the config so we see we are mapping one
thing to another and not just altering an existing variable.

Yours,
Linus Walleij
