From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 21 May 2015 10:09:42 +0200
Subject: [PATCH 1/5] soc: mediatek: Add infracfg misc driver support
In-Reply-To: <1432131540-2523-2-git-send-email-s.hauer@pengutronix.de>
References: <1432131540-2523-1-git-send-email-s.hauer@pengutronix.de>
 <1432131540-2523-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1432195782.21715.123.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a nit: an unneeded macro.

On Wed, 2015-05-20 at 16:18 +0200, Sascha Hauer wrote:

> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig

> +config MTK_INFRACFG
> +	bool "MediaTek INFRACFG Support"
> +	depends on ARCH_MEDIATEK
> +	select REGMAP
> +	help
> +	  Say yes here to add support for the MediaTek INFRACFG controller. The
> +	  INFRACFG controller contains various infrastructure registers not
> +	  directly associated to any device.
> +

> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile

> +obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o

> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-infracfg.c

> +#include <linux/module.h>

> +MODULE_LICENSE("GPL v2");

MTK_INFRACFG was changed from tristate to bool in this version.

Note that for built-in code MODULE_LICENSE() will be effectively
preprocessed away. So you can drop that macro, and the include of
linux/module.h too. (I did a quick compile to see if nothing else
requires module.h, and it compiled cleanly without that include.)

Thanks,


Paul Bolle
