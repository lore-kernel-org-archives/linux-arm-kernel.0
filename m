From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 28 Nov 2017 20:02:26 +0800
Subject: [PATCH 12/17] drm/sun4i: Add CCSC property to DE2 configuration
In-Reply-To: <20171127205750.19277-13-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
 <20171127205750.19277-13-jernej.skrabec@siol.net>
Message-ID: <1763fe2cf572135ef030a26a32b907d7@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-11-28 04:57?Jernej Skrabec ???
> Base addresses of channel output CSC (CCSC) depends whether mixer in
> question is first or second and if it is second, if supports VEP or 
> not.
> This new property will tell which set of base addresses to take.
> 
> 0 - first mixer or second mixer with VEP support
> 1 - second mixer without VEP support

Maxime,

I think here the ID of the mixer matters.

P.S. I didn't found any SoC with a second mixer with VEP currently

Thanks!

> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 1 +
>  drivers/gpu/drm/sun4i/sun8i_mixer.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index 7c9c87a0535b..2276eff8798d 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -622,6 +622,7 @@ static const struct sun8i_mixer_cfg 
> sun8i_v3s_mixer_cfg = {
>  	.vi_num = 2,
>  	.ui_num = 1,
>  	.scaler_mask = 0x3,
> +	.ccsc = 0,

Jernej, the lowlevel_sun8iw8/de_feat.c in the BSP DE2 source code
claims that V3/V3s have no VEP support even for mixer0.

>  };
> 
>  static const struct of_device_id sun8i_mixer_of_table[] = {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> index 355a45e6cfb4..4fcf1653e345 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> @@ -136,6 +136,7 @@ struct sun8i_mixer_cfg {
>  	int		vi_num;
>  	int		ui_num;
>  	int		scaler_mask;
> +	int		ccsc;
>  };
> 
>  struct sun8i_mixer {
