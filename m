From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Jun 2013 09:09:38 +0200
Subject: [PATCH] staging: imx-drm: Add MODULE_DEVICE_TABLE to parallel
 display
In-Reply-To: <1370597806-15718-1-git-send-email-jiada_wang@mentor.com>
References: <1370597806-15718-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <20130617070938.GF32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 06:36:46PM +0900, Jiada Wang wrote:
> Add a MODULE_DEVICE_TABLE annotation so that parallel display module
> can be autoloaded based on the device-tree information.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/staging/imx-drm/parallel-display.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
> index e7fba62..3c4e2c6 100644
> --- a/drivers/staging/imx-drm/parallel-display.c
> +++ b/drivers/staging/imx-drm/parallel-display.c
> @@ -265,6 +265,7 @@ static const struct of_device_id imx_pd_dt_ids[] = {
>  	{ .compatible = "fsl,imx-parallel-display", },
>  	{ /* sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, imx_pd_dt_ids);
>  
>  static struct platform_driver imx_pd_driver = {
>  	.probe		= imx_pd_probe,
> -- 
> 1.8.1.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
