From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 15 Dec 2015 16:42:03 +0100
Subject: [PATCH] soc: mediatek: SCPSYS: use module_platform_driver
In-Reply-To: <3837885.qE6MXzvvpu@wuerfel>
References: <1450188966-2921-1-git-send-email-s.hauer@pengutronix.de>
 <3837885.qE6MXzvvpu@wuerfel>
Message-ID: <20151215154203.GP11966@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 03:30:01PM +0100, Arnd Bergmann wrote:
> On Tuesday 15 December 2015 15:16:06 Sascha Hauer wrote:
> > @@ -542,6 +542,7 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
> >  };
> >  
> >  static struct platform_driver scpsys_drv = {
> > +       .probe = scpsys_probe,
> >         .driver = {
> >                 .name = "mtk-scpsys",
> >                 .owner = THIS_MODULE,
> > @@ -549,4 +550,4 @@ static struct platform_driver scpsys_drv = {
> >         },
> >  };
> >  
> > -module_platform_driver_probe(scpsys_drv, scpsys_probe);
> > +module_platform_driver(scpsys_drv);
> > 
> 
> Good idea, but I wonder why there is no remove function in the
> driver. Do we also need to make the module non-removable and
> set .suppress_bind_attrs, or is all of the probe function
> reversible through devm_* helpers?

pm domains currently can't be unregistered, removal of this driver is
not supported. The driver can't be compiled as a module.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
