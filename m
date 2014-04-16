From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 16 Apr 2014 11:54:35 +0200
Subject: [PATCH 0/4] pinctrl: sirf: switch to one gpiolib and
 gpiolib_irqchip helpers
In-Reply-To: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CABxcv=khupV0gpnCUOPeRON_v2wcRCNkL2Ao1B5dOB9-OB0wyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Barry,

On Tue, Apr 15, 2014 at 8:43 AM, Barry Song <21cnbao@gmail.com> wrote:
> From: Barry Song <Baohua.Song@csr.com>
>
> This patchset depends on Linus Walleij's "pinctrl: sirf: rename inlined accessor".
> and "pinctrl: sirf: switch driver to use gpiolib irqchip helpers" is rebased
> from Linus Walleij's patch too.
>
> Barry Song (3):
>   pinctrl: sirf: wrap all gpio banks into one gpio_chip
>   gpio: make handler_data configurable while using gpiolib_irqchip
>   pinctrl: sirf: move to use irq_get_handler_data
> Linus Walleij (1):
>   pinctrl: sirf: switch driver to use gpiolib irqchip helpers
>
>  drivers/gpio/gpiolib.c              |   10 +-
>  drivers/pinctrl/Kconfig             |    1 +
>  drivers/pinctrl/sirf/pinctrl-sirf.c |  264 ++++++++++++-----------------------
>  include/linux/gpio/driver.h         |    2 +-
>  4 files changed, 97 insertions(+), 180 deletions(-)
>
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Maybe you can first do the parameter change to
gpiochip_set_chained_irqchip() and then just convert to gpiolib
irqchip passing the struct sirfsoc_gpio_bank pointer instead of a
struct gpio_chip. I think there is no need to split PATCH 2 and PATCH
4 but it is up to you.

The series looks good to me:

Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>
