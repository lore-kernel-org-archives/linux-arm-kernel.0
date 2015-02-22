From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Feb 2015 21:13:23 +0100
Subject: [PATCH] ARM: bcm2835: Add header file for pinctrl constants
In-Reply-To: <1424624396-812-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1424624396-812-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Message-ID: <5700696.0jJhSRhno5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 February 2015 16:59:56 Charles Keepax wrote:
> +
> +/* IRQ Flags */
> +#define BCM2835_PIN_IRQ_RISING                         1
> +#define BCM2835_PIN_IRQ_FALLING                                2
> +#define BCM2835_PIN_IRQ_EDGE   (BCM2835_PIN_IRQ_RISING | \
> +                                BCM2835_PIN_IRQ_FALLING)
> +#define BCM2835_PIN_IRQ_LOW                            4
> +#define BCM2835_PIN_IRQ_HIGH                           8

Are these different from the standard definitions?

> +/* Pin Function Settings */
> +#define BCM2835_PIN_FUNC_GPIO_IN                       0
> +#define BCM2835_PIN_FUNC_GPIO_OUT                      1
> +#define BCM2835_PIN_FUNC_ALT5                          2
> +#define BCM2835_PIN_FUNC_ALT4                          3
> +#define BCM2835_PIN_FUNC_ALT0                          4
> +#define BCM2835_PIN_FUNC_ALT1                          5
> +#define BCM2835_PIN_FUNC_ALT2                          6
> +#define BCM2835_PIN_FUNC_ALT3                          7

Why are these required? They don't seem to be used by any driver,
which leads me to suspect that they are just the hardware numbers.

In that case, don't add any syntactical sugar like that and just
use the hardware numbers directly.

What's with the strange mapping of numbers anyway?

	Arnd
