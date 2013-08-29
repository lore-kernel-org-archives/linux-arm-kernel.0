From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Aug 2013 20:40:41 +0200
Subject: [PATCH v5 2/3] ARM: bcm281xx: Enable GPIO driver
In-Reply-To: <1377728173-30711-3-git-send-email-markus.mayer@linaro.org>
References: <1377728173-30711-1-git-send-email-markus.mayer@linaro.org>
 <1377728173-30711-3-git-send-email-markus.mayer@linaro.org>
Message-ID: <CACRpkdbWnzcgjRZnUj5x6a42SZc2+fr5etT3_Z9zqjTz+qQB5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 12:16 AM, Markus Mayer <markus.mayer@linaro.org> wrote:

> This patch adds the Kconfig and Makefile glue to compile the GPIO
> driver for bcm281xx when CONFIG_GPIO_BCM=y.
>
> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
(...)

> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index b2450ba..b68e9b5 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -714,6 +714,11 @@ config GPIO_MSIC
>           Enable support for GPIO on intel MSIC controllers found in
>           intel MID devices
>
> +config GPIO_BCM_KONA
> +       bool "Broadcom Kona GPIO"
> +       help
> +         Turn on GPIO support for Broadcom "Kona" chips.
> +
>  comment "USB GPIO expanders:"
>
>  config GPIO_VIPERBOARD
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index ef3e983..fcd0751 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_GPIO_ADP5520)    += gpio-adp5520.o
>  obj-$(CONFIG_GPIO_ADP5588)     += gpio-adp5588.o
>  obj-$(CONFIG_GPIO_AMD8111)     += gpio-amd8111.o
>  obj-$(CONFIG_GPIO_ARIZONA)     += gpio-arizona.o
> +obj-$(CONFIG_GPIO_BCM_KONA)    += gpio-bcm-kona.o
>  obj-$(CONFIG_GPIO_BT8XX)       += gpio-bt8xx.o
>  obj-$(CONFIG_GPIO_CLPS711X)    += gpio-clps711x.o
>  obj-$(CONFIG_GPIO_CS5535)      += gpio-cs5535.o

Move these two hunks of the patch over to patch 1.

I prefer to have the driver added along with the Kconfig and
Makefile changes.

Yours,
Linus Walleij
