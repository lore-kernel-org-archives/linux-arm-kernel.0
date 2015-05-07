From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 07 May 2015 10:10:47 +0200
Subject: [PATCH 3/6] pinctrl: sunxi: Add H3 PIO controller support
In-Reply-To: <1430904693-1404-4-git-send-email-jenskuske@gmail.com>
References: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
 <1430904693-1404-4-git-send-email-jenskuske@gmail.com>
Message-ID: <1430986247.8171.37.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-06 at 11:31 +0200, Jens Kuske wrote:
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
 
> +config PINCTRL_SUN8I_H3
> +	def_bool MACH_SUN8I
> +	select PINCTRL_SUNXI_COMMON

> --- a/drivers/pinctrl/sunxi/Makefile
> +++ b/drivers/pinctrl/sunxi/Makefile

> +obj-$(CONFIG_PINCTRL_SUN8I_H3)		+= pinctrl-sun8i-h3.o

PINCTRL_SUN8I_H3 is a bool symbol, so pinctrl-sun8i-h3.o will never be
part of a module, right?

(Note that PINCTRL_SUN8I_H3 appears to be an alias for MACH_SUN8I. Ie,
these two symbols operate in lockstep.)

> --- /dev/null
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c

> +#include <linux/module.h>

> +MODULE_DEVICE_TABLE(of, sun8i_h3_pinctrl_match);

> +MODULE_AUTHOR("Jens Kuske <jenskuske@gmail.com>");
> +MODULE_DESCRIPTION("Allwinner H3 pinctrl driver");
> +MODULE_LICENSE("GPL");

This adds some module specific boilerplate. Was it perhaps your
intention to make PINCTRL_SUN8I_H3 a tristate symbol?

Thanks,


Paul Bolle
