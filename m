From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 11 Jul 2018 15:44:05 +0200
Subject: [PATCH] [v2] drm/sun4i: fix build failure with
 CONFIG_DRM_SUN8I_MIXER=m
In-Reply-To: <20180709160615.2686055-1-arnd@arndb.de>
References: <20180709160615.2686055-1-arnd@arndb.de>
Message-ID: <20180711134405.yh4c5g3ckmqyldmo@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2018 at 06:05:55PM +0200, Arnd Bergmann wrote:
> Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
> a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:
> 
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!
> 
> This solves the problem by adding a silent symbol for the tcon_top module,
> building it as a separate module in exactly the cases that we need it,
> but in a way that it is reachable by the other modules.
> 
> Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
> Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph with TCON TOP")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Actually, this was conflicting with some rework I merged at the time,
can you rebase and resend?

Thanks! (and sorry)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/94de4955/attachment.sig>
