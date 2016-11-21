From: jsarha@ti.com (Jyri Sarha)
Date: Mon, 21 Nov 2016 19:26:07 +0200
Subject: [PATCH] drm: tilcdc: reduce max_width for revision 1
In-Reply-To: <1479748590-3962-2-git-send-email-bgolaszewski@baylibre.com>
References: <1479748590-3962-1-git-send-email-bgolaszewski@baylibre.com>
 <1479748590-3962-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <2013ba47-e7e4-045e-0232-4ebd7450c3ad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/16 19:16, Bartosz Golaszewski wrote:
> It has been determined that the highest resolution supported correctly
> by LCDC rev1 is 800x600. Reduce the max_width value for rev1 to 800 in
> crtc_max_width().
> 

I don't think this is the right way to limit the supported video modes.
There is technically there is no such limit, is there?

If memory bandwidth is limiting the functionality of higher resolutions,
you should use "max-bandwidth" tilcdc device-tree property [1].

Cheers,
Jyri

[1] In "Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt":
Optional properties:
 - max-bandwidth: The maximum pixels per second that the memory
   interface / lcd controller combination can sustain



> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> index dfe3dd0..9081de5 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> @@ -683,7 +683,7 @@ int tilcdc_crtc_max_width(struct drm_crtc *crtc)
>  	int max_width = 0;
>  
>  	if (priv->rev == 1)
> -		max_width = 1024;
> +		max_width = 800;
>  	else if (priv->rev == 2)
>  		max_width = 2048;
>  
> 
