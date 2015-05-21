From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 21 May 2015 10:22:07 +0200
Subject: [PATCH 3/5] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <1432131540-2523-4-git-send-email-s.hauer@pengutronix.de>
References: <1432131540-2523-1-git-send-email-s.hauer@pengutronix.de>
 <1432131540-2523-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1432196527.21715.130.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-20 at 16:18 +0200, Sascha Hauer wrote:
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig

> +config MTK_SCPSYS
> +	bool "MediaTek SCPSYS Support"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	select REGMAP
> +	select MTK_INFRACFG
> +	help
> +	  Say yes here to add support for the MediaTek SCPSYS power domain
> +	  driver.

> +obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o

> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-scpsys.c

> +#include <linux/module.h>

> +MODULE_DEVICE_TABLE(of, of_scpsys_match_tbl);
> +
> +static struct platform_driver scpsys_drv = {

> +		.owner = THIS_MODULE,

> +};
> +
> +module_platform_driver_probe(scpsys_drv, scpsys_probe);

(A patch was recently submitted that would allow built-in only code to
use builtin_platform_driver_probe(), see
https://lkml.org/lkml/2015/5/10/125 .)

> +MODULE_AUTHOR("Sascha Hauer, Pengutronix");
> +MODULE_DESCRIPTION("MediaTek MT8173 scpsys driver");
> +MODULE_LICENSE("GPL v2");

MTK_SCPSYS was changed from tristate to bool in this version. As
mtk-scpsys.o can now only be built-in I think the above module specific
macros can safely be dropped. Probably ditto for the module.h include.

Thanks,


Paul Bolle
