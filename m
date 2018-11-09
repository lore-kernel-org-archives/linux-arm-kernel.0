From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Nov 2018 10:24:28 +0100
Subject: [PATCH v2] pinctrl: lpc18xx: Use define directive for
 PIN_CONFIG_GPIO_PIN_INT
In-Reply-To: <20181101150007.14145-1-natechancellor@gmail.com>
References: <20181101005257.8778-1-natechancellor@gmail.com>
 <20181101150007.14145-1-natechancellor@gmail.com>
Message-ID: <CACRpkdZLywABfeHYvV6wGKU7iVe-RVHBB+12iCC3-7BxmcRpeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2018 at 4:02 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> Clang warns when one enumerated type is implicitly converted to another:
>
> drivers/pinctrl/pinctrl-lpc18xx.c:643:29: warning: implicit conversion
> from enumeration type 'enum lpc18xx_pin_config_param' to different
> enumeration type 'enum pin_config_param' [-Wenum-conversion]
>         {"nxp,gpio-pin-interrupt", PIN_CONFIG_GPIO_PIN_INT, 0},
>         ~                          ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/pinctrl/pinctrl-lpc18xx.c:648:12: warning: implicit conversion
> from enumeration type 'enum lpc18xx_pin_config_param' to different
> enumeration type 'enum pin_config_param' [-Wenum-conversion]
>         PCONFDUMP(PIN_CONFIG_GPIO_PIN_INT, "gpio pin int", NULL, true),
>         ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> macro 'PCONFDUMP'
>         .param = a, .display = b, .format = c, .has_arg = d     \
>                  ^
> 2 warnings generated.
>
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/140
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:

This v2 version applied.

Yours,
Linus Walleij
