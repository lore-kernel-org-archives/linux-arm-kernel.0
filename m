From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 4 May 2018 12:25:47 +0100
Subject: [PATCH v1 03/13] drm/kms/mode/exynos-dsi: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
In-Reply-To: <1525421726-2817-1-git-send-email-satendra.t@samsung.com>
References: <00b4a624-d2b6-dc6a-71c0-9c7642480a44@arm.com>
 <CGME20180504081613epcas5p405d342fe333975048175c4a360067f52@epcas5p4.samsung.com>
 <1525421726-2817-1-git-send-email-satendra.t@samsung.com>
Message-ID: <920ac8d1-8d2d-1332-256d-21472f69fca5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/18 09:15, Satendra Singh Thakur wrote:
> To avoid duplicate logic for the same
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Please read section 13 of Documentation/process/submitting-patches.rst 
for what this tag means; specifically, it is definitely not "this guy 
read my patch".

FWIW, in my case the patches I give trivial coding style comments on 
tend to be the ones I'm specifically *not* in a position to review in a 
technical capacity - the reason I'm looking at them in the first place 
is out of interest to learn more about how the relevant subsystems work.

Robin.

> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> Acked-by: Madhur Verma <madhur.verma@samsung.com>
> Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
> ---
>   drivers/gpu/drm/exynos/exynos_drm_dsi.c | 13 ++-----------
>   1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index 7904ffa..7fe84fd 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1490,17 +1490,8 @@ static void exynos_dsi_mode_set(struct drm_encoder *encoder,
>   				struct drm_display_mode *adjusted_mode)
>   {
>   	struct exynos_dsi *dsi = encoder_to_dsi(encoder);
> -	struct videomode *vm = &dsi->vm;
> -	struct drm_display_mode *m = adjusted_mode;
> -
> -	vm->hactive = m->hdisplay;
> -	vm->vactive = m->vdisplay;
> -	vm->vfront_porch = m->vsync_start - m->vdisplay;
> -	vm->vback_porch = m->vtotal - m->vsync_end;
> -	vm->vsync_len = m->vsync_end - m->vsync_start;
> -	vm->hfront_porch = m->hsync_start - m->hdisplay;
> -	vm->hback_porch = m->htotal - m->hsync_end;
> -	vm->hsync_len = m->hsync_end - m->hsync_start;
> +
> +	drm_display_mode_to_videomode(adjusted_mode, &dsi->vm);
>   }
>   
>   static const struct drm_encoder_helper_funcs exynos_dsi_encoder_helper_funcs = {
> 
