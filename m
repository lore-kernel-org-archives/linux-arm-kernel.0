From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 9 Jul 2018 10:07:24 +0200
Subject: [PATCH] drm/sun4i: fix build failure with CONFIG_DRM_SUN8I_MIXER=m
In-Reply-To: <20180706124628.3192421-1-arnd@arndb.de>
References: <20180706124628.3192421-1-arnd@arndb.de>
Message-ID: <20180709080724.3ekqb45fsjubvhcm@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 02:45:53PM +0200, Arnd Bergmann wrote:
> Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
> a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:
> 
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!
> 
> This solves the problem by making DRM_SUN8I_MIXER a 'bool' symbol, building
> the sun8i_tcon_top module the same way as the core sun4i-drm module whenever
> DRM_SUN8I_MIXER is enabled, or not building it at all otherwise.
> 
> Alternatively, we could always build sun8i_tcon_top.ko along with sun4-drm.ko
> and detach it from the mixer module, I could not tell which way is more
> appropriate here.

If that's easily doable, then yeah, that would be the preferred option
I guess. Jernej? Chen-Yu? Any opinion on this?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180709/1dbcfbfc/attachment.sig>
