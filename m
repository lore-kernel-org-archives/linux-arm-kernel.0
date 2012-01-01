From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 1 Jan 2012 15:22:07 +0100
Subject: [PATCH v3 3/3] gpio: pxa: request pinmux function for gpio
In-Reply-To: <1324541855-19911-4-git-send-email-haojian.zhuang@marvell.com>
References: <1324541855-19911-1-git-send-email-haojian.zhuang@marvell.com>
 <1324541855-19911-4-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CACRpkda_0ECowDhg2wWx9wLHgVVcRKycLYR=AgNrHVBum2ibLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 9:17 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:

> While gpio is requested for pxa, gpio driver will request function ready
> on pin.
(...)

> +#ifdef CONFIG_PINMUX
> +static int pxa_gpio_request(struct gpio_chip *chip, unsigned offset)
> +{
> + ? ? ? return pinmux_request_gpio(chip->base + offset);
> +}
> +
> +static void pxa_gpio_free(struct gpio_chip *chip, unsigned offset)
> +{
> + ? ? ? pinmux_free_gpio(chip->base + offset);
> +}
> +#else
> +static int pxa_gpio_request(struct gpio_chip *chip, unsigned offset) {return 0;}
> +static void pxa_gpio_free(struct gpio_chip *chip, unsigned offset) {}
> +#endif
> +

Skip the #ifdef, the pinmux portion of pinctrl already provides stubs if
CONFIG_PINMUX is not selected. See <linux/pinctrl/pinmux.h>

Yours,
Linus Walleij
