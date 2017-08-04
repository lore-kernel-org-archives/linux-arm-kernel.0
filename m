From: sandy.huang@rock-chips.com (Sandy Huang)
Date: Fri, 4 Aug 2017 08:57:12 +0800
Subject: [PATCH 5/6] drm/rockchip: vop: report error when check resource
 error
In-Reply-To: <1501494596-7090-1-git-send-email-mark.yao@rock-chips.com>
References: <1501494569-6825-1-git-send-email-mark.yao@rock-chips.com>
 <1501494596-7090-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <2fc3b65f-de19-b55d-7425-1d50aeb22a6e@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi mark,

? 2017/7/31 17:49, Mark Yao ??:
> The user would be confused while facing a error commit without
> any error report.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index fa0d9f7..999c2e0 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -674,8 +674,10 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
>   	 * Src.x1 can be odd when do clip, but yuv plane start point
>   	 * need align with 2 pixel.
>   	 */
> -	if (is_yuv_support(fb->format->format) && ((state->src.x1 >> 16) % 2))
> +	if (is_yuv_support(fb->format->format) && ((state->src.x1 >> 16) % 2)) {
> +		DRM_ERROR("Invalid Source: Yuv format not support odd xpos\n");
>   		return -EINVAL;
> +	}
>   
>   	return 0;
>   }
> 

Reviewed-by: Sandy huang <sandy.huang@rock-chips.com>
