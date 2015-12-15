From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Dec 2015 15:30:01 +0100
Subject: [PATCH] soc: mediatek: SCPSYS: use module_platform_driver
In-Reply-To: <1450188966-2921-1-git-send-email-s.hauer@pengutronix.de>
References: <1450188966-2921-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <3837885.qE6MXzvvpu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 December 2015 15:16:06 Sascha Hauer wrote:
> @@ -542,6 +542,7 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
>  };
>  
>  static struct platform_driver scpsys_drv = {
> +       .probe = scpsys_probe,
>         .driver = {
>                 .name = "mtk-scpsys",
>                 .owner = THIS_MODULE,
> @@ -549,4 +550,4 @@ static struct platform_driver scpsys_drv = {
>         },
>  };
>  
> -module_platform_driver_probe(scpsys_drv, scpsys_probe);
> +module_platform_driver(scpsys_drv);
> 

Good idea, but I wonder why there is no remove function in the
driver. Do we also need to make the module non-removable and
set .suppress_bind_attrs, or is all of the probe function
reversible through devm_* helpers?

	Arnd
