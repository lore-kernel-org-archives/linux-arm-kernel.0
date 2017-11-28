From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Nov 2017 21:44:57 +0100
Subject: [PATCH 12/17] drm/sun4i: Add CCSC property to DE2 configuration
In-Reply-To: <20171127205750.19277-13-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
 <20171127205750.19277-13-jernej.skrabec@siol.net>
Message-ID: <20171128204457.gvqjskiw7kruw24v@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 09:57:45PM +0100, Jernej Skrabec wrote:
> Base addresses of channel output CSC (CCSC) depends whether mixer in
> question is first or second and if it is second, if supports VEP or not.
> This new property will tell which set of base addresses to take.
> 
> 0 - first mixer or second mixer with VEP support
> 1 - second mixer without VEP support
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 1 +
>  drivers/gpu/drm/sun4i/sun8i_mixer.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index 7c9c87a0535b..2276eff8798d 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -622,6 +622,7 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
>  	.vi_num = 2,
>  	.ui_num = 1,
>  	.scaler_mask = 0x3,
> +	.ccsc = 0,
>  };
>  
>  static const struct of_device_id sun8i_mixer_of_table[] = {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> index 355a45e6cfb4..4fcf1653e345 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> @@ -136,6 +136,7 @@ struct sun8i_mixer_cfg {
>  	int		vi_num;
>  	int		ui_num;
>  	int		scaler_mask;
> +	int		ccsc;

Having some documentation for that one would be great too.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/786e0968/attachment.sig>
