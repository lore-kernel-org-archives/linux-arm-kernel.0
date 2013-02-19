From: rui.zhang@intel.com (Zhang Rui)
Date: Tue, 19 Feb 2013 23:48:08 +0800
Subject: [PATCH 9/9] thermal: rcar: remove __devinitconst
In-Reply-To: <1360880818-4071454-10-git-send-email-arnd@arndb.de>
References: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
 <1360880818-4071454-10-git-send-email-arnd@arndb.de>
Message-ID: <1361288888.2323.30.camel@rzhang1-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-02-14 at 23:26 +0100, Arnd Bergmann wrote:
> commit 76cc18874 "thermal: rcar: add Device Tree support"
> added device tree support for this driver, but also added
> an instance of __devinitconst, which is no longer defined
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Zhang Rui <rui.zhang@intel.com>

applied to thermal -next tree.

thanks,
rui
> ---
>  drivers/thermal/rcar_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 909bb4b..28f0919 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -476,7 +476,7 @@ static int rcar_thermal_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id rcar_thermal_dt_ids[] __devinitconst = {
> +static const struct of_device_id rcar_thermal_dt_ids[] = {
>  	{ .compatible = "renesas,rcar-thermal", },
>  	{},
>  };
