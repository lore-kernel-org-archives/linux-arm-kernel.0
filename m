From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 3 Jun 2011 08:54:14 -0300
Subject: [PATCH v2 3/4] ARM: mxc: migrate mach-imx gpio driver to gpio-mxc
In-Reply-To: <1306985632-18820-4-git-send-email-shawn.guo@linaro.org>
References: <1306985632-18820-1-git-send-email-shawn.guo@linaro.org>
	<1306985632-18820-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <BANLkTikUnDN81f3cv-buqsKUgdqXsRcYhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Thu, Jun 2, 2011 at 12:33 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
...

> +void __init imx1_soc_init(void)
> +{
> + ? ? ? mxc_register_gpio(0, MX1_GPIO1_BASE_ADDR, SZ_4K, MX1_GPIO_INT_PORTA, 0);
> + ? ? ? mxc_register_gpio(1, MX1_GPIO2_BASE_ADDR, SZ_4K, MX1_GPIO_INT_PORTB, 0);
> + ? ? ? mxc_register_gpio(2, MX1_GPIO3_BASE_ADDR, SZ_4K, MX1_GPIO_INT_PORTC, 0);
> + ? ? ? mxc_register_gpio(3, MX1_GPIO4_BASE_ADDR, SZ_4K, MX1_GPIO_INT_PORTD, 0);

By just reading the function names like "imx1_soc_init" we have really
no clue of what it actually does.

"soc_init" is too vague IMHO. Could?t you change the names to
something like "imx1_gpio_init" or "imx1_gpio_register".

It would be nice at least are dealing with gpio.

Regards,

Fabio Estevam
