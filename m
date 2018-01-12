From: inki.dae@samsung.com (Inki Dae)
Date: Fri, 12 Jan 2018 10:20:00 +0900
Subject: [PATCH 03/19] drm/exynos: Use the alpha format helper
In-Reply-To: <345b8966460f13af7e29d2700876572d34f06cf4.1515494838.git-series.maxime.ripard@free-electrons.com>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
 <CGME20180109105704epcas2p1a61d52699557e3f79c631ea7f9614efc@epcas2p1.samsung.com>
 <345b8966460f13af7e29d2700876572d34f06cf4.1515494838.git-series.maxime.ripard@free-electrons.com>
Message-ID: <5A580D40.9070504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



2018? 01? 09? 19:56? Maxime Ripard ?(?) ? ?:
> Now that the core has a drm format helper to tell if a format embeds an
> alpha component in it, let's use it.
> 
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Inki Dae <inki.dae@samsung.com>

Thanks,
Inki Dae

> ---
>  drivers/gpu/drm/exynos/exynos_mixer.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
> index dc5d79465f9b..d7339a6d072c 100644
> --- a/drivers/gpu/drm/exynos/exynos_mixer.c
> +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
> @@ -179,18 +179,6 @@ static const u8 filter_cr_horiz_tap4[] = {
>  	70,	59,	48,	37,	27,	19,	11,	5,
>  };
>  
> -static inline bool is_alpha_format(unsigned int pixel_format)
> -{
> -	switch (pixel_format) {
> -	case DRM_FORMAT_ARGB8888:
> -	case DRM_FORMAT_ARGB1555:
> -	case DRM_FORMAT_ARGB4444:
> -		return true;
> -	default:
> -		return false;
> -	}
> -}
> -
>  static inline u32 vp_reg_read(struct mixer_context *ctx, u32 reg_id)
>  {
>  	return readl(ctx->vp_regs + reg_id);
> @@ -625,7 +613,7 @@ static void mixer_graph_buffer(struct mixer_context *ctx,
>  	mixer_reg_write(ctx, MXR_GRAPHIC_BASE(win), dma_addr);
>  
>  	mixer_cfg_layer(ctx, win, priority, true);
> -	mixer_cfg_gfx_blend(ctx, win, is_alpha_format(fb->format->format));
> +	mixer_cfg_gfx_blend(ctx, win, drm_format_has_alpha(fb->format->format));
>  
>  	/* layer update mandatory for mixer 16.0.33.0 */
>  	if (ctx->mxr_ver == MXR_VER_16_0_33_0 ||
> 
