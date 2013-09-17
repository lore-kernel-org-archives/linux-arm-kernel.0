From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Sep 2013 14:41:23 +0200
Subject: [PATCH 6/7] ARM: ixp4: delete irq_to_gpio
In-Reply-To: <1378816295-8205-1-git-send-email-linus.walleij@linaro.org>
 (Linus Walleij's message of "Tue, 10 Sep 2013 14:31:35 +0200")
References: <1378816295-8205-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <m3a9jbtybw.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> This dangerous function is not used in the kernel, so let's
> just delete it.

Acked-by: Krzysztof Halasa <khc@pm.waw.pl>

> +++ b/arch/arm/mach-ixp4xx/common.c
> @@ -117,17 +117,6 @@ static int ixp4xx_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
>  	return -EINVAL;
>  }
>  
> -int irq_to_gpio(unsigned int irq)
> -{
> -	int gpio = (irq < 32) ? irq2gpio[irq] : -EINVAL;
> -
> -	if (gpio == -1)
> -		return -EINVAL;
> -
> -	return gpio;
> -}
> -EXPORT_SYMBOL(irq_to_gpio);
> -

-- 
Krzysztof Halasa
