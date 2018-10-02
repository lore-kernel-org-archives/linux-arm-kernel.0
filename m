From: ville.syrjala@linux.intel.com (Ville =?iso-8859-1?Q?Syrj=E4l=E4?=)
Date: Tue, 2 Oct 2018 18:34:56 +0300
Subject: [Intel-gfx] [PATCH 09/18] drm/atmel: Drop transitional hooks
In-Reply-To: <20181002133526.13685-10-daniel.vetter@ffwll.ch>
References: <20181002133526.13685-1-daniel.vetter@ffwll.ch>
 <20181002133526.13685-10-daniel.vetter@ffwll.ch>
Message-ID: <20181002153456.GY9144@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2018 at 03:35:17PM +0200, Daniel Vetter wrote:
> These do absolutely nothing for atomic drivers.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-arm-kernel at lists.infradead.org

Reviewed-by: Ville Syrj?l? <ville.syrjala@linux.intel.com>

> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index 9e34bce089d0..96f4082671fe 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -364,9 +364,7 @@ static void atmel_hlcdc_crtc_atomic_flush(struct drm_crtc *crtc,
>  
>  static const struct drm_crtc_helper_funcs lcdc_crtc_helper_funcs = {
>  	.mode_valid = atmel_hlcdc_crtc_mode_valid,
> -	.mode_set = drm_helper_crtc_mode_set,
>  	.mode_set_nofb = atmel_hlcdc_crtc_mode_set_nofb,
> -	.mode_set_base = drm_helper_crtc_mode_set_base,
>  	.atomic_check = atmel_hlcdc_crtc_atomic_check,
>  	.atomic_begin = atmel_hlcdc_crtc_atomic_begin,
>  	.atomic_flush = atmel_hlcdc_crtc_atomic_flush,
> -- 
> 2.19.0.rc2
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Ville Syrj?l?
Intel
