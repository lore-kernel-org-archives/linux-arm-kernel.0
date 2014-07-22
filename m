From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Jul 2014 09:52:25 +0100
Subject: [PATCH] drm: shmobile: fix warnings
In-Reply-To: <E1X6Ho7-0006ru-U9@rmk-PC.arm.linux.org.uk>
References: <E1X6Ho7-0006ru-U9@rmk-PC.arm.linux.org.uk>
Message-ID: <20140722085225.GI21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 13, 2014 at 12:19:03PM +0100, Russell King wrote:
> drivers/gpu/drm/shmobile/shmob_drm_drv.c:300:5: warning: "CONFIG_PM_SLEEP" is not defined [-Wundef]
> 
> Always use #ifdef with CONFIG symbols, never just bare #if
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Ping?

> ---
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> index 82c84c7fd4f6..ff4ba483b602 100644
> --- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> @@ -297,7 +297,7 @@ static struct drm_driver shmob_drm_driver = {
>   * Power management
>   */
>  
> -#if CONFIG_PM_SLEEP
> +#ifdef CONFIG_PM_SLEEP
>  static int shmob_drm_pm_suspend(struct device *dev)
>  {
>  	struct shmob_drm_device *sdev = dev_get_drvdata(dev);
> -- 
> 1.8.3.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
