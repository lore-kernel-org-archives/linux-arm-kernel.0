From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 May 2017 11:24:53 +0200
Subject: [PATCH v7 04/13] drm/sun4i: return only planes for layers created
In-Reply-To: <20170514163045.40366-5-icenowy@aosc.io>
References: <20170514163045.40366-1-icenowy@aosc.io>
 <20170514163045.40366-5-icenowy@aosc.io>
Message-ID: <20170515092453.uv5j3avcktgx4no5@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 12:30:36AM +0800, Icenowy Zheng wrote:
> As we are going to add support for the Allwinner DE2 Mixer in sun4i-drm
> driver, we will finally have two types of layers.
> 
> Each layer is bound to a drm_plane that is CRTC-specific, so we create
> them when initializing CRTC (calling sun4i_layers_init, which will be
> generalized in next patch). The drm_plane's will be used when creating
> CRTC, but the CRTC initialization code do not care other properties of
> the layer, so we let the sun4i_layers_init function return drm_plane's
> only.
> 
> As we have no need to trace the layers after the CRTC is properly
> created, we drop the layers pointer in sun4i_crtc struct.
> 
> Doing this uncouples the CRTC code from the type of layer (the
> sun4i_layers_init function name is still hardcoded and will be changed
> in the next patch), so that we can finally gain support for the
> mixer in DE2, which has different layers.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170515/d0b10328/attachment.sig>
