From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 2 Feb 2017 11:45:14 +0100
Subject: [PATCH 2/2] drm: meson: rename driver name to meson-drm
In-Reply-To: <1486028864-19622-3-git-send-email-narmstrong@baylibre.com>
References: <1486028864-19622-1-git-send-email-narmstrong@baylibre.com>
 <1486028864-19622-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <20170202104514.nogjnsuimeulml53@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 10:47:44AM +0100, Neil Armstrong wrote:
> The platform driver name is currently "meson" which can lead to some
> confusion, this patch renames it to "meson-drm" and removes the owner
> attribute.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index ff1f601..380bde7 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -329,8 +329,7 @@ static int meson_drv_remove(struct platform_device *pdev)
>  	.probe      = meson_drv_probe,
>  	.remove     = meson_drv_remove,
>  	.driver     = {
> -		.owner  = THIS_MODULE,

I don't get why you remove this, generally that will lead to trouble of
being able to unload code that's still in use ...

Otherwise ack.

Now, do you want to get this landed as part of the small drivers in
drm-mis experiment?
-Daniel

> -		.name   = DRIVER_NAME,
> +		.name	= "meson-drm",
>  		.of_match_table = dt_match,
>  	},
>  };
> -- 
> 1.9.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
