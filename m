From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Sep 2016 18:46:19 +0200
Subject: [PATCH v2] drm/sun4i: Clear encoder->bridge if a bridge is not
 found
In-Reply-To: <20160901061332.1803-1-wens@csie.org>
References: <20160901061332.1803-1-wens@csie.org>
Message-ID: <20160901164619.GF20462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2016 at 02:13:32PM +0800, Chen-Yu Tsai wrote:
> The KMS helpers (drm_atomic_helper_check_modeset/mode_fixup) pass
> encoder->bridge directly to drm_bridge_mode_fixup, which expects a
> valid pointer, or NULL (in which case it just returns).
> 
> Clear encoder->bridge if a bridge is not found, instead of keeping
> the ERR_PTR value.
> 
> Since other drm_bridge functions also follow this pattern of checking
> for a non-NULL pointer, we can drop the ifs around the calls and just
> pass the pointer directly.
> 
> Fixes: 894f5a9f4b4a ("drm/sun4i: Add bridge support")
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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160901/50fb977c/attachment.sig>
