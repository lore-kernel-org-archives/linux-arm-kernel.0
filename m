From: mark.yao@rock-chips.com (Mark yao)
Date: Sat, 10 Sep 2016 10:59:34 +0800
Subject: [PATCH] drm/rockchip: mark symbols static where possible
In-Reply-To: <1473246088-780-1-git-send-email-baoyou.xie@linaro.org>
References: <1473246088-780-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <57D37716.5000902@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?09?07? 19:01, Baoyou Xie wrote:
> We get 2 warnings when building kernel with W=1:
> drivers/gpu/drm/rockchip/rockchip_drm_drv.c:309:6: warning: no previous prototype for 'rockchip_drm_fb_suspend' [-Wmissing-prototypes]
> drivers/gpu/drm/rockchip/rockchip_drm_drv.c:318:6: warning: no previous prototype for 'rockchip_drm_fb_resume' [-Wmissing-prototypes]
>
> In fact, these functions are only used in the file in which they are
> declared and don't need a declaration, but can be made static.
> So this patch marks these functions with 'static'.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Applied to my drm-fixes, Thanks

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index a822d49..3723683 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -306,7 +306,7 @@ static struct drm_driver rockchip_drm_driver = {
>   };
>   
>   #ifdef CONFIG_PM_SLEEP
> -void rockchip_drm_fb_suspend(struct drm_device *drm)
> +static void rockchip_drm_fb_suspend(struct drm_device *drm)
>   {
>   	struct rockchip_drm_private *priv = drm->dev_private;
>   
> @@ -315,7 +315,7 @@ void rockchip_drm_fb_suspend(struct drm_device *drm)
>   	console_unlock();
>   }
>   
> -void rockchip_drm_fb_resume(struct drm_device *drm)
> +static void rockchip_drm_fb_resume(struct drm_device *drm)
>   {
>   	struct rockchip_drm_private *priv = drm->dev_private;
>   


-- 
?ark Yao ???

Rockchip ???????????

Fuzhou Headquarters

Addr:No.21 Building, A District, Fuzhou

Software Park, 89 Soft Avenue, Tongpan Road,

Gulou District, Fuzhou (350003)

??:?????????????89????A?21?? (350003)

Tel:?86-0591?83991906 - 8296

E-mail:mark.yao at rock-chips.com
