From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 07 Jul 2015 11:14:32 +0200
Subject: [PATCH 1/7] pinctrl: UniPhier: add UniPhier pinctrl core support
In-Reply-To: <1436185763-4308-2-git-send-email-yamada.masahiro@socionext.com>
References: <1436185763-4308-1-git-send-email-yamada.masahiro@socionext.com>
 <1436185763-4308-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1436260472.20057.121.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(I only comment on 1/7, because it's not useful to repeat one remark
seven times.)

On ma, 2015-07-06 at 21:29 +0900, Masahiro Yamada wrote:
> --- /dev/null
> +++ b/drivers/pinctrl/uniphier/Kconfig

> +config PINCTRL_UNIPHIER_CORE
> +	bool
> +	select PINMUX
> +	select GENERIC_PINCONF

> --- /dev/null
> +++ b/drivers/pinctrl/uniphier/Makefile

> +obj-$(CONFIG_PINCTRL_UNIPHIER_CORE)		+= pinctrl-uniphier-core.o

> --- /dev/null
> +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c

> +#include <linux/module.h>

> +int uniphier_pinctrl_probe(struct platform_device *pdev,
> +			   struct pinctrl_desc *desc,
> +			   struct uniphier_pinctrl_socdata *socdata)
> +{
> +	[...]

> +	desc->owner = THIS_MODULE;

> +	[...]
> +}

This series adds a number of bool Kconfig symbols. So, as far as I can
see, the code it adds can only be built-in.

This series also uses a number of module specific constructs (ie,
THIS_MODULE, MODULE_DEVICE_TABLE, module_exit, MODULE_AUTHOR,
MODULE_DESCRIPTION, and MODULE_LICENSE). So I wonder whether it was
intended to make these new Kconfig symbols tristate instead?

Thanks,


Paul Bolle
