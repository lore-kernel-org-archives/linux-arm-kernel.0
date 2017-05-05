From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 5 May 2017 11:05:30 +0800
Subject: [linux-sunxi] [PATCH 04/13] drm/sun4i: return only planes for
 layers created
In-Reply-To: <20170504114208.8524-4-icenowy@aosc.io>
References: <20170504114208.8524-1-icenowy@aosc.io>
 <20170504114208.8524-4-icenowy@aosc.io>
Message-ID: <CAGb2v64xwoNC1puWZXb010Sxh27tp9xNSCupuftzBoKCMi-Edw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 4, 2017 at 7:41 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
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
> Doing these things makes the CRTC code independent to the type of layer

Doing this uncouples the CRTC code from the type of layer.

> (the sun4i_layers_init function name is still hardcoded and will be
> changed in the next patch), so that we can finally gain support for the
> mixer in DE2, which will has different layers.

... which has ...

>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
