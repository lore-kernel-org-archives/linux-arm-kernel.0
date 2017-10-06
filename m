From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 06 Oct 2017 22:46:59 +0200
Subject: [PATCH] mtd: nand: gpio: Convert to use GPIO descriptors
In-Reply-To: <20170924173912.9199-1-linus.walleij@linaro.org> (Linus Walleij's
 message of "Sun, 24 Sep 2017 19:39:12 +0200")
References: <20170924173912.9199-1-linus.walleij@linaro.org>
Message-ID: <87fuawf1h8.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

>  #if defined(CONFIG_MTD_NAND_GPIO) || defined(CONFIG_MTD_NAND_GPIO_MODULE)
> +
> +static struct gpiod_lookup_table cmx255_nand_gpiod_table = {
> +	.dev_id         = "cmx255-nand",
Shouldn't the device name be "gpio-nand" instead ?
"cmx255-nand" is AFAIR a partition name, not a device name.

Cheers.

-- 
Robert
