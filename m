From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Nov 2017 21:42:32 +0100
Subject: [PATCH 11/17] drm/sun4i: Wire in DE2 scaler support
In-Reply-To: <20171127205750.19277-12-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
 <20171127205750.19277-12-jernej.skrabec@siol.net>
Message-ID: <20171128204232.rf2jhb2fih5eo7r4@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 09:57:44PM +0100, Jernej Skrabec wrote:
> Calculate scaling parameters and call appropriate scaler set up
> function.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

I'm not sure there's been something wrong, but I didn't receive your
patch 10. I guess this one could be folded in patch 9.

> @@ -194,29 +195,34 @@ int sun8i_mixer_update_ui_layer_coord(struct sun8i_mixer *mixer,
>  				      int layer, struct drm_plane *plane)
>  {
>  	struct drm_plane_state *state = plane->state;
> -	u32 width, height, size;
> +	u32 src_w, src_h, dst_w, dst_h;
> +	u32 outsize, insize;
> +	u32 hphase, vphase;
>  
> -	DRM_DEBUG_DRIVER("Updating layer %d\n", layer);
> +	DRM_DEBUG_DRIVER("Updating UI layer %d\n", layer);

And this would be part of the VI support patch 

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/e4282780/attachment.sig>
