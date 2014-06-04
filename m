From: robherring2@gmail.com (Rob Herring)
Date: Wed, 4 Jun 2014 12:23:33 -0500
Subject: [PATCH 0/4] <mach/gpio.h> purge
In-Reply-To: <1401888838-3126-1-git-send-email-linus.walleij@linaro.org>
References: <1401888838-3126-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAL_JsqL9_hbn-XDCm368YEPuW2mNnYio_-pAgUNOMw-7kd7MOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 4, 2014 at 8:33 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> After deleting <mach/gpio.h> from the AT91 only S5P remains.
> This patch set fixes up S5P and then removes NEED_MACH_GPIO_H
> permanently removing any references to <mach/gpio.h> from the
> ARM kernel. Do a small cleanout of a dangling reference to
> ARM_GPIOLIB_COMPLEX at the same time.

Awesome.

>
> Linus Walleij (4):
>   ARM: s5p: cut the custom ARCH_NR_GPIOS definition
>   ARM: mach-s5p: get rid of all <mach/gpio.h> headers
>   ARM: kill CONFIG_NEED_MACH_GPIO_H
>   ARM: delete old reference to ARM_GPIOLIB_COMPLEX
>
>  arch/arm/Kconfig                                  |  10 --
>  arch/arm/include/asm/gpio.h                       |   7 --
>  arch/arm/mach-s5p64x0/common.c                    |   2 +-
>  arch/arm/mach-s5p64x0/dev-audio.c                 |   3 +-
>  arch/arm/mach-s5p64x0/include/mach/gpio-samsung.h | 127 +++++++++++++++++++
>  arch/arm/mach-s5p64x0/include/mach/gpio.h         | 132 --------------------

Use -M option or set git config diff.renames=true so you don't have to remember.

Rob
