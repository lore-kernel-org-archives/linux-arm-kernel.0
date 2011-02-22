From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 22 Feb 2011 16:13:05 +0300
Subject: [PATCH 1/6] ARM: tegra: add tegra_gpio_table and tegra_gpio_config
In-Reply-To: <1298354117-19097-2-git-send-email-olof@lixom.net>
References: <1298354117-19097-1-git-send-email-olof@lixom.net>
	<1298354117-19097-2-git-send-email-olof@lixom.net>
Message-ID: <4D63B661.6000407@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-02-2011 8:55, Olof Johansson wrote:

> To give one place to setup the pins that are used as GPIOs instead
> of as their pinmuxed functions. Specifying enabled as false explicitly
> disables the gpio mode of that pin (if left on by firmware).

> This should remove the need for calling these from specific drivers and
> thus reduce tegra-specific code from them.

> Signed-off-by: Olof Johansson<olof@lixom.net>
[...]

> diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
> index e31f486..2369fba 100644
> --- a/arch/arm/mach-tegra/include/mach/gpio.h
> +++ b/arch/arm/mach-tegra/include/mach/gpio.h
> @@ -20,6 +20,7 @@
>   #ifndef __MACH_TEGRA_GPIO_H
>   #define __MACH_TEGRA_GPIO_H
>
> +#include<linux/init.h>
>   #include<mach/irqs.h>
>
>   #define TEGRA_NR_GPIOS		INT_GPIO_NR
> @@ -47,6 +48,12 @@ static inline int irq_to_gpio(unsigned int irq)
>   	return -EINVAL;
>   }
>
> +struct tegra_gpio_table {
> +	int	gpio;	/* GPIO number */
> +	bool	enable;	/* Enable for GPIO at init? */
> +};
> +
> +void __init tegra_gpio_config(struct tegra_gpio_table *table, int num);

    You don't need to annotate the declaration as __init.

WBR, Sergei
