From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 9 Jun 2015 10:42:07 +0200
Subject: [PATCH 3/5] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <1432196527.21715.130.camel@x220>
References: <1432131540-2523-1-git-send-email-s.hauer@pengutronix.de>
 <1432131540-2523-4-git-send-email-s.hauer@pengutronix.de>
 <1432196527.21715.130.camel@x220>
Message-ID: <20150609084207.GN26575@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 10:22:07AM +0200, Paul Bolle wrote:
> On Wed, 2015-05-20 at 16:18 +0200, Sascha Hauer wrote:
> > --- a/drivers/soc/mediatek/Kconfig
> > +++ b/drivers/soc/mediatek/Kconfig
> 
> > +config MTK_SCPSYS
> > +	bool "MediaTek SCPSYS Support"
> > +	depends on ARCH_MEDIATEK || COMPILE_TEST
> > +	select REGMAP
> > +	select MTK_INFRACFG
> > +	help
> > +	  Say yes here to add support for the MediaTek SCPSYS power domain
> > +	  driver.
> 
> > +obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> 
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> 
> > +#include <linux/module.h>
> 
> > +MODULE_DEVICE_TABLE(of, of_scpsys_match_tbl);
> > +
> > +static struct platform_driver scpsys_drv = {
> 
> > +		.owner = THIS_MODULE,
> 
> > +};
> > +
> > +module_platform_driver_probe(scpsys_drv, scpsys_probe);
> 
> (A patch was recently submitted that would allow built-in only code to
> use builtin_platform_driver_probe(), see
> https://lkml.org/lkml/2015/5/10/125 .)

I'll switch to this when it's available. Right now I don't want to have
this as an additional dependency.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
