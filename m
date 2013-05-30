From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 20:19:01 +0200
Subject: [PATCH 08/11] ARM: davinci: start using gpiolib support
In-Reply-To: <1369206634-6778-9-git-send-email-avinashphilip@ti.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
 <1369206634-6778-9-git-send-email-avinashphilip@ti.com>
Message-ID: <CACRpkdauO5Tgkec-g5N85+M2AejUmvF+rO-5V7Yc5vKUMNpm4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 9:10 AM, Philip Avinash <avinashphilip@ti.com> wrote:

> - Remove NEED_MACH_GPIO_H config option for Davinci platforms to start
>   using common gpio library interface.
> - Added struct davinci_gpio_controller definitions in platform_data
>   directory for Davinci gpio devices.
> - Removed GPIO_TYPE_DAVINCI enum definition as GPIO Davinci is converted
>   to Linux device driver model.
>
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

> +/* Convert GPIO signal to GPIO pin number */
> +#define GPIO_TO_PIN(bank, gpio)        (16 * (bank) + (gpio))

Hm not synonymous with pinctrl pins, well I guess I have to live
with this...

Yours,
Linus Walleij
