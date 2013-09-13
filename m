From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Fri, 13 Sep 2013 14:15:32 +0200
Subject: [PATCH 5/7] staging: media/lirc: switch to use gpiolib
In-Reply-To: <1378816283-8164-1-git-send-email-linus.walleij@linaro.org>
 (Linus Walleij's message of "Tue, 10 Sep 2013 14:31:23 +0200")
References: <1378816283-8164-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <m3d2ocvrx7.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> +++ b/drivers/staging/media/lirc/lirc_serial.c
> @@ -839,6 +839,16 @@ static int lirc_serial_probe(struct platform_device *dev)
>  {
>  	int i, nlow, nhigh, result;
>  
> +#ifdef CONFIG_LIRC_SERIAL_NSLU2
> +	/* This GPIO is used for a LED on the NSLU2 */
> +	result = devm_gpio_request(dev, NSLU2_LED_GRN, "lirc-serial");

Will this succeed with the LED driver already loaded? Should the user
unload it first?

Otherwise, while I don't have any of the hw in question, I can't see
other obvious problems, so for the whole patchset:

Acked-by: Krzysztof Halasa <khc@pm.waw.pl>
-- 
Krzysztof Halasa
