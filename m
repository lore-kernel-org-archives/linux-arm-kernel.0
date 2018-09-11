From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Sep 2018 21:10:27 +0100
Subject: next-20180911 build: 1 failures 15 warnings (next-20180911)
In-Reply-To: <E1fzodE-000398-4K@optimist>
References: <E1fzodE-000398-4K@optimist>
Message-ID: <20180911201027.GI10123@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 08:47:28PM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm64 defconfig due to:

> 	arm64-defconfig
> ERROR: "sun8i_tcon_top_de_config" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
> ERROR: "sun8i_tcon_top_set_hdmi_src" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!

DRM_SUN4I unconditionally uses these symbols which are only defined when
DRM_SUN8I_TOP is enabled, not sure what the exact cause is but there's a
few recent patches to that driver from Jonathan and Chen-Yu so CCing for
that.  I've been missing arm64 builds for a little while so this
could've been there before today.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180911/ba106954/attachment-0001.sig>
