From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 12 Feb 2015 21:37:53 +0100
Subject: [PATCH 08/14] pinctrl: Add pinctrl driver for STM32 MCUs
In-Reply-To: <1423763164-5606-9-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1423763164-5606-9-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CAMuHMdXfAENN5EB6nFJdf3bJPJ+=41Po22NKrQWdwkyf5nFXpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 6:45 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -125,6 +125,15 @@ config PINCTRL_ST
>         select PINCONF
>         select GPIOLIB_IRQCHIP
>
> +config PINCTRL_STM32
> +       bool "STMicroelectronics STM32 pinctrl driver"
> +       depends on OF

depends on ARCH_STM32 || COMPILE_TEST

> +       select PINMUX
> +       select PINCONF
> +       select GPIOLIB_IRQCHIP
> +       help
> +         This selects the device tree based generic pinctrl driver for STM32.
> +
>  config PINCTRL_TEGRA
>         bool
>         select PINMUX

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
