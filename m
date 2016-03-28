From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 28 Mar 2016 14:40:05 +0800
Subject: [PATCH] drm/rockchip: vop: Don't reject empty modesets
In-Reply-To: <1458300123-6397-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1458300123-6397-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <56F8D1C5.6060504@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?03?18? 19:22, Tomeu Vizoso wrote:
> So that when DRM_IOCTL_MODE_SETCRTC is called without a FB nor mode, the
> CRTC gets disabled.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Link: http://lkml.kernel.org/g/CAAObsKAv+05ih5U+=4kic_NsjGMhfxYheHR8xXXmacZs+p5SHw at mail.gmail.com
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index fd370548d7d7..5e57f5b2e4b0 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -885,9 +885,6 @@ static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
>   {
>   	struct vop *vop = to_vop(crtc);
>   
> -	if (adjusted_mode->htotal == 0 || adjusted_mode->vtotal == 0)
> -		return false;
> -
>   	adjusted_mode->clock =
>   		clk_round_rate(vop->dclk, mode->clock * 1000) / 1000;
>   
Applied to my drm-fixes, Thanks.

-- 
?ark Yao
