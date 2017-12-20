From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Dec 2017 09:05:29 +0100
Subject: [PATCH v4 4/4] ARM: pinctrl: sunxi-pinctrl: fix pin funtion can
 not be match correctly.
In-Reply-To: <20171213144748.GA18267@arx-s1>
References: <20171213144748.GA18267@arx-s1>
Message-ID: <CACRpkdYtn6N6MOqS=oFXDcfgmkN8-qJY5tJpWP8+9JBb1gU9Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 13, 2017 at 3:47 PM, hao_zhang <hao5781286@gmail.com> wrote:
> Pin function can not be match correctly when SUNXI_PIN describe with
> mutiple variant and same function.
>
> such as:
> on pinctrl-sun4i-a10.c
>
> SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
>                 SUNXI_FUNCTION(0x0, "gpio_in"),
>                 SUNXI_FUNCTION(0x1, "gpio_out"),
>                 SUNXI_FUNCTION_VARIANT(0x2, "pwm",    /* PWM0 */
>                         PINCTRL_SUN4I_A10 |
>                         PINCTRL_SUN7I_A20),
>                 SUNXI_FUNCTION_VARIANT(0x3, "pwm",    /* PWM0 */
>                         PINCTRL_SUN8I_R40)),
>
> it would always match to the first variant function
> (PINCTRL_SUN4I_A10, PINCTRL_SUN7I_A20)
>
> so we should add variant compare on it.
>
> Signed-off-by: hao_zhang <hao5781286@gmail.com>

Please resend patch with Maxime's suggestions fixed and his
ACK added so I can apply it.

I can take this patch separatelt, it does not need to be part of
the PWM series.

Yours,
Linus Walleij
