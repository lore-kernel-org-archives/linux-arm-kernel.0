From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 7 Nov 2012 10:39:00 +0530
Subject: [PATCH 1/5] gpiolib: fix up function prototypes etc
In-Reply-To: <1352214994-30232-1-git-send-email-linus.walleij@stericsson.com>
References: <1352214994-30232-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAKohpon2OBMgNjc5RRGibEUqN_yPGPdXX5RBFP-bQLmyeF4zuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 November 2012 20:46, Linus Walleij <linus.walleij@stericsson.com>wrote:

> diff --git a/include/linux/gpio.h b/include/linux/gpio.h
>


> -void gpiochip_add_pin_range(struct gpio_chip *chip, const char
> *pinctl_name,
> -               unsigned int pin_base, unsigned int npins);
> -void gpiochip_remove_pin_ranges(struct gpio_chip *chip);
> -#endif
> +#ifdef CONFIG_PINCTRL
>

Shouldn't this be ifndef??


> +static inline void
> +gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
> +                      unsigned int pin_base, unsigned int npins)
> +{
> +}
> +
> +static inline void
> +gpiochip_remove_pin_ranges(struct gpio_chip *chip)
> +{
> +}
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121107/e384fe03/attachment-0001.html>
