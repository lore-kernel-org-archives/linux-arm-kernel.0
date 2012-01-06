From: ben-i2c@fluff.org (Ben Dooks)
Date: Fri, 6 Jan 2012 16:28:20 +0000
Subject: [PATCH] OMAP: I2C: add devexit to the remove code
In-Reply-To: <1324365959-4143-1-git-send-email-shubhrajyoti@ti.com>
References: <1324365959-4143-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120106162820.GB8441@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 12:55:59PM +0530, Shubhrajyoti D wrote:
> The omap_i2c_remove function may not be needed after
> device exit so the memory could be freed.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Will add this later.

> ---
>  drivers/i2c/busses/i2c-omap.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index fa23faa..2efdc6b 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1111,8 +1111,7 @@ err_release_region:
>  	return r;
>  }
>  
> -static int
> -omap_i2c_remove(struct platform_device *pdev)
> +static int __devexit omap_i2c_remove(struct platform_device *pdev)
>  {
>  	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
>  	struct resource		*mem;
> @@ -1161,7 +1160,7 @@ static struct dev_pm_ops omap_i2c_pm_ops = {
>  
>  static struct platform_driver omap_i2c_driver = {
>  	.probe		= omap_i2c_probe,
> -	.remove		= omap_i2c_remove,
> +	.remove		= __devexit_p(omap_i2c_remove),
>  	.driver		= {
>  		.name	= "omap_i2c",
>  		.owner	= THIS_MODULE,
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
