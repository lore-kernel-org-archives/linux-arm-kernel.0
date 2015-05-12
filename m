From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 12 May 2015 11:24:31 +0200
Subject: [PATCH 1/5] soc: mediatek: Add infracfg misc driver support
In-Reply-To: <1431372206-1237-2-git-send-email-s.hauer@pengutronix.de>
References: <1431372206-1237-1-git-send-email-s.hauer@pengutronix.de>
 <1431372206-1237-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1431422671.2398.155.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-05-11 at 21:23 +0200, Sascha Hauer wrote:
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig

> +config MTK_INFRACFG
> +	tristate "MediaTek INFRACFG Support"
> +	depends on ARCH_MEDIATEK
> +	select REGMAP
> +	help
> +	  Say yes here to add support for the MediaTek INFRACFG controller. The
> +	  INFRACFG controller contains various infrastructure registers not
> +	  directly associated to any device.

> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile

> +obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o

> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-infracfg.c

> +EXPORT_SYMBOL_GPL(mtk_infracfg_set_bus_protection);

> +EXPORT_SYMBOL_GPL(mtk_infracfg_clear_bus_protection);

As I understand it, if both MTK_INFRACFG and MTK_SCPSYS (see 3/5) are m
we will get mtk-infracfg.ko and mtk-scpsys.ko (see 3/5). And loading
mtk-scpsys.ko will trigger loading mtk-infracfg.ko, right?

But since this file has no MODULE_LICENSE() that should generate a
warning and taint the kernel. (I haven't tested this. Please correct me
if I'm overlooking something here.)

Thanks,


Paul Bolle
