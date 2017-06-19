From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 19 Jun 2017 12:37:35 +0200
Subject: [PATCH] drm: exynos: constify mixer_match_types and
 *_mxr_drv_data.
In-Reply-To: <28c361b34389bfc40fbca6250f6ff24f5f7afe97.1497866987.git.arvind.yadav.cs@gmail.com>
References: <CGME20170619101327epcas2p27bb709ee46519fade54663884ef74c88@epcas2p2.samsung.com>
 <28c361b34389bfc40fbca6250f6ff24f5f7afe97.1497866987.git.arvind.yadav.cs@gmail.com>
Message-ID: <109c96fc-5d91-f88e-55d3-927dfe5cfba1@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.06.2017 12:12, Arvind Yadav wrote:
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    9983	   1424	      0	  11407	   2c8f	drivers/gpu/drm/exynos/exynos_mixer.o
>
> File size after constify:
>    text	   data	    bss	    dec	    hex	filename
>   11231	    176	      0	  11407	   2c8f	drivers/gpu/drm/exynos/exynos_mixer.o
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

> ---
>  drivers/gpu/drm/exynos/exynos_mixer.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
> index 25edb63..778cae2 100644
> --- a/drivers/gpu/drm/exynos/exynos_mixer.c
> +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
> @@ -1097,28 +1097,28 @@ static int mixer_atomic_check(struct exynos_drm_crtc *crtc,
>  	.atomic_check		= mixer_atomic_check,
>  };
>  
> -static struct mixer_drv_data exynos5420_mxr_drv_data = {
> +static const struct mixer_drv_data exynos5420_mxr_drv_data = {
>  	.version = MXR_VER_128_0_0_184,
>  	.is_vp_enabled = 0,
>  };
>  
> -static struct mixer_drv_data exynos5250_mxr_drv_data = {
> +static const struct mixer_drv_data exynos5250_mxr_drv_data = {
>  	.version = MXR_VER_16_0_33_0,
>  	.is_vp_enabled = 0,
>  };
>  
> -static struct mixer_drv_data exynos4212_mxr_drv_data = {
> +static const struct mixer_drv_data exynos4212_mxr_drv_data = {
>  	.version = MXR_VER_0_0_0_16,
>  	.is_vp_enabled = 1,
>  };
>  
> -static struct mixer_drv_data exynos4210_mxr_drv_data = {
> +static const struct mixer_drv_data exynos4210_mxr_drv_data = {
>  	.version = MXR_VER_0_0_0_16,
>  	.is_vp_enabled = 1,
>  	.has_sclk = 1,
>  };
>  
> -static struct of_device_id mixer_match_types[] = {
> +static const struct of_device_id mixer_match_types[] = {
>  	{
>  		.compatible = "samsung,exynos4210-mixer",
>  		.data	= &exynos4210_mxr_drv_data,
