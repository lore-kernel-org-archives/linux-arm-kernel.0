From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 Feb 2017 10:22:24 -0800
Subject: [PATCH 04/11] drm/sun4i: Move layers from sun4i_drv to sun4i_crtc
In-Reply-To: <20170223080543.6659-5-wens@csie.org>
References: <20170223080543.6659-1-wens@csie.org>
 <20170223080543.6659-5-wens@csie.org>
Message-ID: <20170223182224.7njvrm7oyr2izity@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 04:05:36PM +0800, Chen-Yu Tsai wrote:
> This patch moves the sun4i_layers_init call from sun4i_drv_bind to
> sun4i_crtc_init, and the layers pointer from struct sun4i_drv to
> struct sun4i_crtc.
> 
> The layers are bound to a specific crtc, and they are not directly
> used once initiated. They are used through their included drm_plane
> structures.
> 
> Moving the layers into the crtc facilitates binding them to the crtc
> explicitly, by setting the corresponding bit in their .possible_crtcs
> fields right after the crtc is initialized. This is done in a later
> patch.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170223/ad06343d/attachment-0001.sig>
