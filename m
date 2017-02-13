From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Feb 2017 09:32:32 +0100
Subject: [PATCH 5/8] drm/sun4i: Add encoder type argument to
 sun4i_tcon0_mode_set
In-Reply-To: <20170211174405.28395-6-plaes@plaes.org>
References: <20170211174405.28395-1-plaes@plaes.org>
 <20170211174405.28395-6-plaes@plaes.org>
Message-ID: <20170213083232.rfezcsr6tcbz7hiw@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 11, 2017 at 07:44:02PM +0200, Priit Laes wrote:
> Depending on the output type, we have to enable/disable some
> bits conditionally.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/gpu/drm/sun4i/sun4i_rgb.c  | 2 +-
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 3 ++-
>  drivers/gpu/drm/sun4i/sun4i_tcon.h | 3 ++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> index f5e86fe..3d4eb05 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> @@ -179,7 +179,7 @@ static void sun4i_rgb_encoder_mode_set(struct drm_encoder *encoder,
>  	struct sun4i_drv *drv = rgb->drv;
>  	struct sun4i_tcon *tcon = drv->tcon;
>  
> -	sun4i_tcon0_mode_set(tcon, mode);
> +	sun4i_tcon0_mode_set(tcon, mode, DRM_MODE_ENCODER_DAC);

This is not the proper encoder type. You can just use encoder_type in
drm_encoder.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170213/102fab86/attachment.sig>
