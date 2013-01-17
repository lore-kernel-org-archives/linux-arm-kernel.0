From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Jan 2013 15:10:15 +0100
Subject: [PATCH 1/2 RESEND] gpio: fix warning of 'struct gpio_chip'
 declaration
In-Reply-To: <1358431402-29701-1-git-send-email-shawn.guo@linaro.org>
References: <1358239056-703-2-git-send-email-shawn.guo@linaro.org>
 <1358431402-29701-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdbwokgBh55nFcDMc50CYmyuGd6AQF88Md=Le-UxJ=p6rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 3:03 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> The struct gpio_chip is only defined inside #ifdef CONFIG_GPIOLIB,
> but it's referenced by gpiochip_add_pin_range() and
> gpiochip_remove_pin_ranges() which are outside #ifdef CONFIG_GPIOLIB.
> Thus, we see the following warning when building blackfin image, where
> GPIOLIB is not required.
>
>   CC      arch/blackfin/kernel/bfin_gpio.o
>   CC      init/version.o
> In file included from arch/blackfin/include/asm/gpio.h:321,
>                  from arch/blackfin/kernel/bfin_gpio.c:15:
> include/asm-generic/gpio.h:298: warning: 'struct gpio_chip' declared inside parameter list
> include/asm-generic/gpio.h:298: warning: its scope is only this definition or declaration, which is probably not what you want
> include/asm-generic/gpio.h:304: warning: 'struct gpio_chip' declared inside parameter list
>
> Move pinctrl trunk into #ifdef CONFIG_GPIOLIB to fix the warning,
> since it appears that pinctrl gpio range support depends on GPIOLIB.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks, patch applied to devel (for-next)

Let's see if something explodes!

Yours,
Linus Walleij
