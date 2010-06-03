From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 3 Jun 2010 20:59:09 +0200 (CEST)
Subject: [PATCH] mioa701: fix camera regression
In-Reply-To: <1275514190-32006-1-git-send-email-robert.jarzmik@free.fr>
References: <1275514190-32006-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <Pine.LNX.4.64.1006032058380.19573@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Jun 2010, Robert Jarzmik wrote:

> Since commit a48c24a696f0d93c49f913b7818e9819612b1f4e, the
> camera is not working anymore.
> 
> After the v4l2 migration, the mt9m111 camera board
> information was not passed to the i2c layer anymore, but
> stored for future use of v4l2 (through soc_camera).
> 
> Because mioa701_i2c_devices[] was tagged as "__initdata",
> and because after the v4l2 migration, the new structure
> "iclink" references it, the mt9m111 driver is not probed
> anymore, as part of "iclink" is not valid (discarded after
> kernel init).
> 
> Although there is not compilation error, nor runtime oops,
> this patch restores a working camera on the mioa701 board.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

> 
> --
> Eric, could you schedule that into your fix branch please ?
> ---
>  arch/arm/mach-pxa/mioa701.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
> index 7a50ed8..9836921 100644
> --- a/arch/arm/mach-pxa/mioa701.c
> +++ b/arch/arm/mach-pxa/mioa701.c
> @@ -696,7 +696,7 @@ static struct i2c_board_info __initdata mioa701_pi2c_devices[] = {
>  };
>  
>  /* Board I2C devices. */
> -static struct i2c_board_info __initdata mioa701_i2c_devices[] = {
> +static struct i2c_board_info mioa701_i2c_devices[] = {
>  	{
>  		I2C_BOARD_INFO("mt9m111", 0x5d),
>  	},
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
