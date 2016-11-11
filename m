From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 11 Nov 2016 09:45:00 +0800
Subject: [PATCH] drm/rockchip: return ERR_PTR instead of NULL
In-Reply-To: <1478812256-26189-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1478812256-26189-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <5825229C.8080704@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?11?11? 05:10, Julia Lawall wrote:
> rockchip_drm_framebuffer_init is only used in one case, in
> rockchip_drm_fbdev.c, where its return value is tested using IS_ERR.  To
> enable propagating the reason for the error, change the definition so that
> it returns an ERR_PTR value.
>
> Problem found with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Thanks for the fix.

Applied to my drm-next.

>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_fb.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> index 0f6eda0..01e11bf 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> @@ -213,7 +213,7 @@ struct drm_framebuffer *
>   
>   	rockchip_fb = rockchip_fb_alloc(dev, mode_cmd, &obj, 1);
>   	if (IS_ERR(rockchip_fb))
> -		return NULL;
> +		return ERR_CAST(rockchip_fb);
>   
>   	return &rockchip_fb->fb;
>   }
>
>
>
>


-- 
?ark Yao
