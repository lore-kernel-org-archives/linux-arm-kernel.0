From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 16:08:26 +0100
Subject: [PATCH v2 11/18] pinctrl: Add pinctrl driver for STM32 MCUs
In-Reply-To: <1424455277-29983-12-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-12-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <2464742.YZIRrHto62@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 February 2015 19:01:10 Maxime Coquelin wrote:
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/pinctrl-stm32.h
> @@ -0,0 +1,43 @@
> +#ifndef _DT_BINDINGS_PINCTRL_STM32_H
> +#define _DT_BINDINGS_PINCTRL_STM32_H
> +
> +/* Modes */
> +#define IN             0
> +#define OUT            1
> +#define ALT            2
> +#define ANALOG         3

I think it's better to prefix all the names with a
string to identify what they are for, otherwise these
are way too generic.

> +/* Alternate functions */
> +#define ALT0           ((0 << 2) | ALT)
> +#define ALT1           ((1 << 2) | ALT)
> +#define ALT2           ((2 << 2) | ALT)
> +#define ALT3           ((3 << 2) | ALT)
> +#define ALT4           ((4 << 2) | ALT)
> +#define ALT5           ((5 << 2) | ALT)
> +#define ALT6           ((6 << 2) | ALT)
> +#define ALT7           ((7 << 2) | ALT)
> +#define ALT8           ((8 << 2) | ALT)
> +#define ALT9           ((9 << 2) | ALT)
> +#define ALT10          ((10 << 2) | ALT)
> +#define ALT11          ((11 << 2) | ALT)
> +#define ALT12          ((12 << 2) | ALT)
> +#define ALT13          ((13 << 2) | ALT)
> +#define ALT14          ((14 << 2) | ALT)
> +#define ALT15          ((15 << 2) | ALT)

You can have a single macro for these like

#define STM32_PIN_ALT(x) ((x << 2) | ALT)

> +/* Pull-Up/Down */
> +#define NO_PULL                0
> +#define PULL_UP                1
> +#define PULL_DOWN      2
> +
> +/* Type */
> +#define PUSH_PULL      (0 << 2)
> +#define OPEN_DRAIN     (1 << 2)
> +

These should probably not be stm32 specific at all, they sound
rather generic, so maybe put the definitions into a common file.



	Arnd
