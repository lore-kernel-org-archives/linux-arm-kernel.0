From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 11 Jan 2010 18:59:40 +0100
Subject: [PATCH] imxfb: correct location of callbacks in suspend and resume
In-Reply-To: <1263226881-28008-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1263226881-28008-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100111175940.GZ6923@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 05:21:21PM +0100, Uwe Kleine-K?nig wrote:
> The probe function passes a pointer to a struct fb_info to
> platform_set_drvdata, so don't interpret the return value of
> platform_get_drvdata as a pointer to struct imxfb_info.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  drivers/video/imxfb.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index 66358fa..b4b6dec 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -593,7 +593,8 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
>   */
>  static int imxfb_suspend(struct platform_device *dev, pm_message_t state)
>  {
> -	struct imxfb_info *fbi = platform_get_drvdata(dev);
> +	struct fb_info *info = platform_get_drvdata(dev);
> +	struct imxfb_info *fbi = info->par;
>  
>  	pr_debug("%s\n", __func__);
>  
> @@ -603,7 +604,8 @@ static int imxfb_suspend(struct platform_device *dev, pm_message_t state)
>  
>  static int imxfb_resume(struct platform_device *dev)
>  {
> -	struct imxfb_info *fbi = platform_get_drvdata(dev);
> +	struct fb_info *info = platform_get_drvdata(dev);
> +	struct imxfb_info *fbi = info->par;
>  
>  	pr_debug("%s\n", __func__);
>  
> -- 
> 1.6.5.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
