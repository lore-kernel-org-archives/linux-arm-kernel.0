From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Aug 2013 19:37:22 +0200
Subject: [PATCH v4 2/3] ARM: bcm281xx: Enable GPIO driver
In-Reply-To: <1376938761-13657-3-git-send-email-markus.mayer@linaro.org>
References: <1376938761-13657-1-git-send-email-markus.mayer@linaro.org>
 <1376938761-13657-3-git-send-email-markus.mayer@linaro.org>
Message-ID: <CACRpkdZ2C_e1187uL2+701P+35cTgDrJB8ze23sGGmnGRstjyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 8:59 PM, Markus Mayer <markus.mayer@linaro.org> wrote:

> This patch adds the Kconfig and Makefile glue to compile the GPIO
> driver for bcm281xx when CONFIG_GPIO_BCM=y.
>
> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
(...)
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -9,7 +9,6 @@ config ARCH_BCM
>         select CLKSRC_OF
>         select GENERIC_CLOCKEVENTS
>         select GENERIC_TIME
> -       select GPIO_BCM

select GPIO_BCM_KONA

>         select SPARSE_IRQ
>         select TICK_ONESHOT
>         help
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index b2450ba..869e234 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -714,6 +714,13 @@ config GPIO_MSIC
>           Enable support for GPIO on intel MSIC controllers found in
>           intel MID devices
>
> +config GPIO_BCM_KONA
> +       bool "Broadcom Kona GPIO"
> +       depends on ARCH_BCM
> +       default y

I prefer that you do not depend on ARCH_BCM and do not
encode default y, but select it in the arch instead. That way
some other system can test-compile it for example.

Which should work fine.

And when that can be done, some of the good kernel
proofreaders and janitors will make a deep review some
day.

Yours,
Linus Walleij
